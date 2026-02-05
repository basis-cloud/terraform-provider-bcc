# basis_port (data source)

> [!NOTE]
> Retrieves information about **ports** available in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_port" "port" {
	vdc_id = data.basis_vdc.single_vdc.id
	ip_address = "0.0.0.0"
	# or
    id = "id"
}

```

**Schema. Required:**

*   `id` (String) — the port ID or `ip_address` (String) — the local IP address of the port;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `network` (String) — the network ID;
*   `tags` (Toset, String) — the list of port tags.