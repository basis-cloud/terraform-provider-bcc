# basis_ports (data source)

> [!NOTE]
> Retrieves a list of **ports** in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_ports" "all_ports" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `ports` (List of Object) — list of ports.

**Nested schema for** `ports`**. Read-only:**

*   `id` (String) — the port ID;
*   `network` (String) — the connected network ID;
*   `ip_address` (String) — the port IP address.