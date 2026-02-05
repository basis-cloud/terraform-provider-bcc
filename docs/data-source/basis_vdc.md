# basis_vdc (data source)

> [!NOTE]
> Retrieves information about a **VDC** for use in other resources. This is useful for utilizing the parameters of a VDC that is not managed via Terraform.

> [!CAUTION]
> If a query of data source is performed by the VDC `name` and the VDC name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_vdc" "single_vdc2" {
	name = "Terraform VDC"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the VDC name or `id` (String) — the VDC ID.

**Schema. Optional:**

*   `project_id` (String) — the project ID.

**Schema. Read-only:**

*   `hypervisor` (String) — the resource pool name;
*   `hypervisor_type` (String) — the resource pool type.