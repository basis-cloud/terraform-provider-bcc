# basis_router (data source)

> [!NOTE]
> Retrieves information about a **router** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the router `name` and the router name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_router" "single_Router" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Terraform Router"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID;
*   `name` (String) — the router name or `id` (String) — the router ID.