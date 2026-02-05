# basis_routers (data source)

> [!NOTE]
> Retrieves a list of **routers** available in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_routers" "vdc_routers" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `routers` (List of Object) (see nested schema below).

**Nested schema for** `routers`**. Read-only:**

*   `id` (String) — the router ID;
*   `name` (String) — the router name.