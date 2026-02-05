# basis_s3_storages (data source)

> [!NOTE]
> Retrieves a list of **S3 storages** located in a project for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_s3_storages" "s3" {
	project_id = data.basis_project.single_project.id
}
```

**Schema. Required:**

*   `project_id` (String) — the project ID.

**Schema. Read-only:**

*   `s3_storages` (List of Object) — the list of S3 storages (see nested schema below).

**Nested schema for** `s3_storages`**. Read-only:**

*   `name` (String) — the S3 storage name;
*   `id` (String) — the storage ID;
*   `access_key` (String) — the storage access key;
*   `client_endpoint` (String) — the storage URL;
*   `secret_key` (String) — the storage secret key;
*   `backend` (String) — the storage type: `minio` or `netapp`.