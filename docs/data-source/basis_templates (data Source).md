# basis_templates (data source)

> [!NOTE]
> Retrieves a list of **server templates** available in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_templates" "single_template" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `templates` (List of Object) (see nested schema below).

**Nested schema for** `templates`**. Read-only:**

*   `id` (String) — the server template ID;
*   `name` (String) — the server template name;
*   `min_cpu` (Integer) — the required minimum number of virtual cores for the server template;
*   `min_disk` (Integer) — the required minimum disk size in GB for the server template;
*   `min_ram` (Integer) — the required minimum amount of RAM in GB for the server template.