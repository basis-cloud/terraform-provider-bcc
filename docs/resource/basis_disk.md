# basis_disk (resource)

> [!NOTE]
> Creating a **disk** that can be attached to a server.

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
    name = "sas"
}

resource "basis_disk" "disk2" {
    vdc_id = data.basis_vdc.single_vdc.id

    name = "Disk 2"
    storage_profile_id = data.basis_storage_profile.single_storage_profile.id
    size = 10
    tags = ["reserve_data"]
}

```

**Schema. Required:**

*   `name` (String) — the disk name;
*   `size` (Integer) — the disk size in GB;
*   `storage_profile_id` (String) — the storage profile ID;
*   `vdc_id` (String) — the VDC ID.

**Schema. Optional:**

*   `tags` (Toset, String) — the list of disk tags.

**Schema. Read-only:**

*   `id` (String) — the disk ID;
*   `external_id` (String) — the disk ID in RUSTACK virtualization platform (for RUSTACK VDC).