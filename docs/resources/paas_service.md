---
page_title: "basis_paas_service Resource - terraform-provider-bcc"
---
# basis_paas_service (Resource)

Provides a Basis PaaS Service resource.

## Example Usage

```hcl
resource "basis_project" "project" {
  name = "terraform paas"
}

data "basis_hypervisor" "hypervisor" {
  project_id = resource.basis_project.project.id
  name = "Рустэк"
}

resource "basis_vdc" "vdc_rustack" {
  name = "terraform Рустэк"
  project_id = resource.basis_project.project.id
  hypervisor_id = data.basis_hypervisor.hypervisor.id
}

data "basis_paas_template" "nginx_template" {
  id = 5
  vdc_id = resource.basis_vdc.vdc_rustack.id
}

resource "basis_paas_service" "db_service" {
  name = "test_paas"
  vdc_id = resource.basis_vdc.vdc_rustack.id
  paas_service_id = data.basis_paas_template.nginx_template.id
  paas_service_inputs = jsonencode({
    "vdcs_id": "58dce2a8-6778-4bb7-8257-05917ee148b3",
    "vm_name": "test_paas_vm",
    "cpu_num": 2,
    "ram_size": 4,
    "storage_profile": "a4d7f671-b778-45d2-86e3-c22e8080b083",
    "volume_size": 10,
    "firewall_profiles": [
      "b759aab1-0c55-4e93-b79c-86fafedf11c9",
      "2d7120b8-b02c-43cd-bfa6-421d887a6fdb",
      "b72b8dac-3063-485b-9d10-09f5e2b8ab49",
      "c516c513-5d51-4632-819c-65b064889117",
      "00000000-0000-0000-0000-000000000000"
    ],
    "network_name": "d60fb2c2-d8a0-4f88-a5bc-97d4d3d7727c",
    "username": "test_paas_user",
    "password": "test_paas_user",
    "ssh_public_key": "",
    "template_name": "110ad34a-f8dc-4b37-af08-6e936f9472c3",
    "enable_ssh_password": true,
    "enable_sudo": true,
    "passwordless_sudo": true
  })
}

```

## Schema

### Required

- **vdc_id** (String) id of the VDC
- **name** (String) name of PaaS Service
- **paas_service_id** (String) id of PaaS Service Template
- **paas_service_inputs** (String) inputs of Paas Service as JSON object


### Read-Only

- **id** (Boolean) id of PaaS Service
