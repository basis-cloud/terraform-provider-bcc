# basis_platform (data source)

> [!NOTE]
> Retrieves information about a **platform** (CPU type) for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the platform `name` and the platform name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}
data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}
data "basis_platform" "platform"{
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Intel Cascade Lake"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID;
*   `name` (String) — the platform name or `id` (String) — the platform ID.