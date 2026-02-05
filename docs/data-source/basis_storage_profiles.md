# basis_storage_profiles (data source)

> [!NOTE]
> Retrieves a list of **storage profiles** available in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_storage_profiles" "all_storage_profiles" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `storage_profiles` (List of Object) (see nested schema below).

**Nested schema for** `storage_profiles`**. Read-only:**

*   `id` (String) — the storage profile ID;
*   `name` (String) — the storage profile name.