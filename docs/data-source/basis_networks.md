# basis_networks (data source)

> [!NOTE]
> Retrieves a list of **networks** available in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_networks" "all_networks" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `networks` (List of Object) (see nested schema below).

**Nested schema for** `networks`**. Read-only:**

*   `id` (String) — the network ID;
*   `name` (String) — the network name;
*   `mtu` (Integer) — the maximum size of a data packet transmitted over the network;
*   `subnets` (List of Object) (see nested schema below).

**Nested schema for** `subnets`**. Read-only:**

*   `cidr` (String) — the subnet CIDR;
*   `dhcp` (Boolean) — indicates whether DHCP is enabled for the subnet, values `true` or `false`;
*   `dns` (List of String) — the list of DNS servers;
*   `end_ip` (String) — the end IP address of the subnet allocation pool;
*   `gateway` (String) — the gateway address for the subnet;
*   `id` (String) — the subnet ID;
*   `start_ip` (String) — the start IP address of the subnet allocation pool.