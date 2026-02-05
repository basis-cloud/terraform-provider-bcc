# basis_s3_storage (resource)

> [!NOTE]
> An **S3 storage** creation, modification and deletion.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

resource "basis_s3_storage" "s3_storage" {
	project_id = data.basis_project.single_project.id
	name = "s3_storage"
	backend = "minio" # or "netapp"
	tags = ["backup"]
}

```

**Schema. Required:**

*   `name` (String) — the S3 storage name;
*   `project_id` (String) — the project ID;
*   `backend` (String) — the storage type: `minio` or `netapp`.

**Schema. Optional:**

*   `tags` (Toset, String) — the list of storage tags.

**Schema. Read-only:**

*   `id` (String) — the storage ID;
*   `access_key` (String) — the storage access key;
*   `client_endpoint` (String) — the storage URL;
*   `secret_key` (String) — the storage secret key.