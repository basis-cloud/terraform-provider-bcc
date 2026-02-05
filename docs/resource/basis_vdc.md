# basis_vdc (resource)

> [!NOTE]
> Creating and managing a **VDC** for building infrastructures.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_hypervisor" "single_hypervisor" {
	project_id = data.basis_project.single_project.id
	name = "VMWARE"
}

resource "basis_vdc" "vdc1" {
	name = "Terraform VDC"
	project_id = data.basis_project.single_project.id
	hypervisor_id = data.basis_hypervisor.single_hypervisor.id
	tags = ["demo"]
}

```

**Schema. Required:**

*   `hypervisor_id` (String) — the resource pool ID;
*   `name` (String) — the VDC name;
*   `project_id` (String) — the project ID.

**Schema. Optional:**

*   `default_network_mtu` (Integer) — the maximum size of a data packet transmitted over the network for the default service network created in the VDC;
*   `tags` (Toset, String) — the list of VDC tags.  
> [!TIP]
> When working with BCC version 5.4.0 and higher, users can enable VDC deletion protection. To do this add the `deletion_protection` tag to the manifest.
> If deletion protection is disabled, deleting the VDC will remove the VDC and all entities created within it. If the protection is enabled, all created entities will be deleted, but the VDC itself will not be removed.
    

**Schema. Read-only:**

*   `id` (String) — the VDC ID;
*   `default_network_id` (String) — the ID of the default service network created in the VDC;
*   `default_network_name` (String) — the name of the default service network created in the VDC;
*   `default_network_subnets` (String) — the list of subnets in the VDC service network (see nested schema below).

**Nested schema for** `default_network_subnets`**. Read-only:**

*   `cidr` (String) — the subnet CIDR;
*   `dhcp` (Boolean) — indicates whether DHCP is enabled for the subnet, values `true` or `false`;
*   `dns` (List of String) — the list of DNS servers;
*   `end_ip` (String) — the end IP address of the subnet allocation pool;
*   `gateway` (String) — the gateway IP address for the subnet;
*   `id` (String) — the subnet ID;
*   `start_ip` (String) — the start IP address of the subnet allocation pool.