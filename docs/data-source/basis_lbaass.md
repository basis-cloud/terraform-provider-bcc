# basis_lbaass (data source)

> [!NOTE]
> Retrieves a list of **load balancers** in a VDC for use in other resources.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_lbaas" "all_lbaass" {
	vdc_id = data.basis_vdc.single_vdc.id
}

```

**Schema. Required:**

*   `vdc_id` (String) — the VDC ID.

**Schema. Read-only:**

*   `lbaass` (List of Object) (see nested schema below).

**Nested schema for** `lbaass`**. Read-only:**

*   `floating` (Boolean) — indicates if the load balancer has a public IP address;
*   `floating_ip` (String) — the load balancer public IP address;
*   `id` (String) — the load balancer ID;
*   `name` (String) — the load balancer name.