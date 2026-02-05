# basis_disk (data source)

> [!NOTE]
> Retrieves information about a **disk** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the disk `name` and the disk name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_disk" "single_disk" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Disk 2"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `name` (String) — the disk name or `id` (String) — the disk ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `size` (Integer) — the disk size in GB;
*   `storage_profile_id` (String) — the storage profile ID;
*   `storage_profile_name` (String) — the storage profile name;
*   `external_id` (String) — the disk ID in the RUSTACK virtualization platform (for RUSTACK VDC).