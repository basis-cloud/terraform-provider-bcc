# basis_firewall_template (data source)

> [!NOTE]
> Retrieves information about a **firewall profile template** for use in other resources.

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

data "basis_firewall_template" "single_template" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Разрешить Web"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the template name or `id` (String) — the template ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `id` (String) — the template ID.