# basis_storage_profile (data source)

> [!NOTE]
> Retrieves information about a **disk storage profile** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the profile `name` and the profile name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_storage_profile" "single_storage_profile" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "ssd"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the storage profile name or `id` (String) — the storage profile ID;
*   `vdc_id` (String) — the VDC ID.