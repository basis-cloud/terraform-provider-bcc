# basis_lbaas (data source)

> [!NOTE]
> Retrieves information about a **load balancer** for use in other resources.

> [!CAUTION]
> If a query of data source is performed by the load balancer `name` and the load balancer name is not unique, this method will return an error.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_lbaas" "test" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "test"
	# or
	id = "id"
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID;
*   `name` (String) — the load balancer name or `id` (String) — the load balancer ID.

**Schema. Read-only:**

*   `floating_ip` (String) — the load balancer public IP address;
*   `floating` (Boolean) — indicates if the load balancer has a public IP address.