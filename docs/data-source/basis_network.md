# basis_network (data source)

> [!NOTE]
> Retrieves information about a **network** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the network `name` and the network name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_network" "single_network" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Сеть 1"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the network name or `id` (String) — the network ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `mtu` (Integer) — the maximum size of a data packet transmitted over the network;
*   `subnets` (List of Object) — the list of subnets (see nested schema below).

**Nested schema for** `subnets`**. Read-only:**

*   `cidr` (String) — the subnet CIDR;
*   `dhcp` (Boolean) — indicates whether DHCP is enabled for the subnet, values `true` or `false`;
*   `dns` (List of String) — the list of DNS servers for the subnet;
*   `end_ip` (String) — the end IP address of the subnet allocation pool;
*   `gateway` (String) — the gateway IP address for the subnet;
*   `id` (String) — the subnet ID;
*   `start_ip` (String) — the start IP address of the subnet allocation pool.