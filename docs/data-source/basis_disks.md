# basis_disks (data source)

> [!NOTE]
> Retrieves a list of **disks** in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_disks" "all_disks" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `disks` (List of Object) (see nested schema below).

**Nested schema for** `disks`**. Read-only:**

*   `external_id` (String) — the disk ID in the RUSTACK virtualization platform (for RUSTACK VDC);
*   `id` (String) — the disk ID;
*   `name` (String) — the disk name;
*   `size` (Integer) — the disk size in GB;
*   `storage_profile_id` (String) — the storage profile ID;
*   `storage_profile_name` (String) — the storage profile name.