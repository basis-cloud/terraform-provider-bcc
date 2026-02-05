# basis_kubernetes (resource)

> [!NOTE]
> A **Kubernetes cluster** creation, modification and deletion.

> [!CAUTION]
> After the cluster is created, the fields `node_ram`, `node_cpu`, `node_disk_size`, `node_storage_profile_id`, `user_public_key_id` are only used when adding a new node (by increasing the `nodes_count` argument) after updating the resource.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

data "basis_network" "service_network" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Сеть"
}

data "basis_storage_profile" "ssd" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "ssd"
}

data "basis_account" "me"{}

data "basis_kubernetes_template" "kubernetes_template" {
    name = "Kubernetes 1.22.1"
    vdc_id = data.basis_vdc.single_vdc.id
    
}

data "basis_pub_key" "key" {
    name = "test"
    account_id = data.basis_account.me.id
}

data "basis_platform" "pl" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Базовая"
}

resource "basis_kubernetes" "k8s" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "test"
    node_ram = 3
    node_cpu = 3
    platform = data.basis_platform.pl.id
    template_id = data.basis_kubernetes_template.kubernetes_template.id
    nodes_count = 2
    node_disk_size = 10
    node_storage_profile_id = data.basis_storage_profile.ssd.id
    user_public_key_id = data.basis_pub_key.key.id
    floating = true
    tags = ["sandbox"]
}

output "dashboard_url" {
    value = resource.basis_kubernetes.k8s.dashboard_url
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID;
*   `name` (String) — the cluster name;
*   `node_cpu` (Integer) — the number of virtual CPU per cluster node;
*   `node_ram` (Integer) — the amount of RAM per cluster node in GB;
*   `template_id` (String) — the Kubernetes template ID;
*   `platform` (String) — the platform (CPU type) ID;
*   `nodes_count` (Integer) — the number of nodes in the cluster; maximum is 64;
*   `node_disk_size` (Integer) — the node disk size in GB;
*   `node_storage_profile_id` (String) — the storage profile ID for the node disks;
*   `user_public_key_id` (String) — the cluster public key ID.

**Schema. Optional:**

*   `floating` (Boolean) — attaching a public IP address to the cluster. Default is `floating = false`.
*   `tags` (Toset, String) — the list of cluster tags.

**Schema. Read-only:**

*   `floating_ip` (String) — the cluster's public IP address;
*   `id` (String) — the cluster ID;
*   `vms` (List) — the list of cluster server `id` (String) values;
*   `dashboard_url` (String) — the Kubernetes management dashboard URL.

**Retrieving information about a Kubernetes cluster.** **Obtaining the URL for accessing the cluster management dashboard:**

This block will output the dashboard URL to the console.

```hcl
output "dashboard_url" {
    value = resource.basis_kubernetes.k8s.dashboard_url
}

```

**Retrieving information about a Kubernetes cluster. Obtaining the** `kubectl` **configuration file:**

After creating the cluster, a configuration file will appear in the working directory.