# basis_vms (data source)

> [!NOTE]
> Retrieves a list of **servers** available in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_vms" "all_vms" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `vms` (List of Objects) (see nested schema below).

**Nested schema for** `vms`**. Read-only:**

*   `cpu` (Integer) — the number of virtual cores of the server;
*   `floating` (Boolean) — indicates whether a public IP address is attached to the server;
*   `floating_ip` (String) — the server's public IP address;
*   `id` (String) — the server ID;
*   `name` (String) — the server name;
*   `ports` (List of Objects) — the list of ports (see nested schema below);
*   `power` (Boolean) — indicates whether the server is powered on or off;
*   `ram` (Integer) — the amount of server RAM in GB;
*   `template_id` (String) — the server template ID;
*   `template_name` (String) — the server template name.

**Nested schema for** `ports`**. Read-only:**

*   `id` (String) — the port ID;
*   `ip_address` (String) — the port IP address.