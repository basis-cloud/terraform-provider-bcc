# basis_platforms (data source)

> [!NOTE]
> Retrieves information about a **list of platforms** (CPU types) for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}
data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}
data "basis_platforms" "platforms"{
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `platforms` (List of Object) (see nested schema below).

**Nested schema for** `platforms`**. Read-only:**

*   `id` (String) — the platform ID;
*   `name` (String) — the platform name.