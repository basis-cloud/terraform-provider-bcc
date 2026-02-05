# basis_s3_storage (data source)

> [!NOTE]
> Retrieves information about an **S3 storage** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the storage `name` and the storage name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_s3_storage" "s3" {
    project_id = data.basis_project.single_project.id
    name = "S3"
    # or
    id = "id"
}

```

**Schema. Required:**

*   `project_id` (String) — the project ID;
*   `name` (String) — the S3 storage name or `id` (String) — the storage ID.

**Schema. Read-only:**

*   `backend` (String) — the storage type: `minio` or `netapp`;
*   `access_key` (String) — the storage access key;
*   `client_endpoint` (String) — the storage URL;
*   `secret_key` (String) — the storage secret key.