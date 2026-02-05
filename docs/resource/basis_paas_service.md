# basis_paas_service (resource)

> [!NOTE]
> A **platform service** creation, modification, and deletion.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_paas_template" "db_template" {
	vdc_id = data.basis_vdc.single_vdc.id
	id = 6
}

data "basis_network" "network1" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Network 1"
}

data "basis_template" "single_template" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Ubuntu 22.04"
}

data "basis_storage_profile" "single_storage_profile" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "SSD"
}

data "basis_firewall_template" "fw1" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Разрешить исходящие"
}

data "basis_firewall_template" "fw2" {
	vdc_id = data.basis_vdc.single_vdc.id
	name = "Разрешить входящие"
}

resource "basis_paas_service" "db_service" {
	vdc_id = data.basis_vdc.single_vdc.id
	paas_service_id = data.basis_paas_template.db_template.id
	name = "psql"
	paas_service_inputs = jsonencode({
		"change_password": false,
		"enable_ssh_password": true,
		"enable_sudo": true,
		"passwordless_sudo": false,
		"cpu_num": 1,
		"ram_size": 1,
		"volume_size": 10,
		"network_name": data.basis_network.network1.id,
		"vdcs_id": data.basis_vdc.single_vdc.id,
		"vm_name": "vm_name",
		"template_name": data.basis_template.single_template.id,
		"storage_profile": data.basis_storage_profile.single_storage_profile.id,
		"firewall_profiles": [data.basis_firewall_template.fw1.id, data.basis_firewall_template.fw2.id],
		"username": "test",
		"password": "test1234"
	})
}

```

**Schema. Required:**

*   `name` (String) — the service name;
*   `vdc_id` (String) — the VDC ID;
*   `paas_service_id` (Integer) — the platform service template ID;
*   `paas_service_inputs` (String) — input data for the service. Instead of `jsonencode(...)`, you can use `file("${path.module}/inputs.json")` to obtain input data from the `inputs.json` file.