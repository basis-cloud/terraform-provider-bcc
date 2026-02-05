# basis_vm (data source)

> [!NOTE]
> Retrieves information about a **server** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the server `name` and the server name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_vm" "single_vm" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Server 1"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the server name or `id` (String) — the server ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `cpu` (Integer) — the number of virtual CPU of the server;
*   `floating` (Boolean) — indicates whether a public IP address is attached to the server;
*   `floating_ip` (String) — the server's public IP address;
*   `power` (Boolean) — indicates whether the server is powered on or off;
*   `ram` (Float) — the amount of server RAM in GB;
*   `template_id` (String) — the server template ID;
*   `template_name` (String) — the server template name;
*   `ports` (List of Objects) — the list of ports (see nested schema below).

**Nested schema for** `ports`**. Read-only:**

*   `id` (String) — the port ID;
*   `ip_address` (String) — the port IP address.