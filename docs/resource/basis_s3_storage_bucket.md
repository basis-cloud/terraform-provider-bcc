# basis_s3_storage_bucket (resource)

> [!NOTE]
> An **S3 storage bucket** creation, modification and deletion.

> [!CAUTION]
> When importing the entity, specific considerations must be taken into account.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_s3_storage" "s3_storage" {
    project_id = data.basis_project.single_project.id
    name = "s3_storage"
}

resource "basis_s3_storage_bucket" "bucket" {
    s3_storage_id = data.basis_s3_storage.s3_storage.id
    name = "Bucket_1"
}

```

**Schema. Required:**

*   `name` (String) — the S3 storage bucket name;
*   `s3_storage_id` (String) — the S3 storage ID.

**Schema. Read-only:**

*   `id` (String) — the S3 storage bucket ID;
*   `external_name` (String) — the S3 storage bucket name for connection and access.