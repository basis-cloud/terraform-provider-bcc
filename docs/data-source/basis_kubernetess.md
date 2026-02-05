# basis_kubernetess (data source)

> [!NOTE]
> Retrieves a list of **Kubernetes clusters** for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_kubernetess" "all_clusters" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `kubernetess` (List of Object) — the list of clusters (see nested schema below).

**Nested schema for** `kubernetess`**. Read-only:**

*   `id` (String) — the cluster ID;
*   `name` (String) — the cluster name;
*   `node_cpu` (Integer) — the number of virtual CPU per cluster node;
*   `floating` (Boolean) — indicates if the cluster has a public IP address;
*   `floating_ip` (String) — the cluster`s public IP address, if present;
*   `nodes_count` (String) — the number of nodes in the cluster;
*   `node_disk_size` (String) — the node disk size specified when the cluster was created;
*   `user_public_key_id` (String) — the cluster public key;
*   `node_storage_profile_id` (String) — the storage profile ID for the node disks;
*   `dashboard_url` (String) — the cluster dashboard URL;
*   `node_ram` (Integer) — the amount of RAM per cluster node;
*   `template_id` (String) — the Kubernetes template ID;
*   `vms` (List) — the list of server nodes ID `id` (String).

> [!CAUTION]
> The arguments `node_cpu`, `node_disk_size`, `node_storage_profile_id`, and `node_ram` contain values set during the Kubernetes cluster creation. If node specifications are changed via the management panel, these values will remain unchanged.

**Retrieving information about a list of Kubernetes clusters.** **Obtaining the URL for accessing the cluster management dashboard:**

This block will output the dashboard URL to the console.

```hcl
output "dashboard_url" {
	value = data.basis_kubernetess.all_clusters.kubernetess[0].dashboard_url
}

```

**Retrieving information about a list of Kubernetes clusters.** **Obtaining the** `kubectl` **configuration file:**

After retrieving the list of clusters, a configuration file will appear in the working directory.