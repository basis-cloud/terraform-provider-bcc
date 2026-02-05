# basis_template (data source)

> [!NOTE]
> Retrieves information about a **server template** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the template `name` and the template name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_template" "single_template" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Debian 10"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the server template name or `id` (String) — the server template ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `min_cpu` (Integer) — the required minimum number of virtual cores for the server template;
*   `min_disk` (Integer) — the required minimum disk size in GB for the server template;
*   `min_ram` (Integer) — the required minimum amount of RAM in GB for the server template.