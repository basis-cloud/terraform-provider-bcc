# basis_port (resource)

> [!NOTE]
> Creating and managing a **port** for connecting a router or server to a network.

> [!CAUTION]
> When upgrading the IaC provider from version **2.0.0** and below to **2.2.0**, port recreation is possible. To avoid this, we recommend adding the following code to the port creation block:

> ```hcl
> lifecycle {
>     ignore_changes = [
>       vdc_id
>     ]
>   }
> ```

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "vdc1" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_firewall_template" "allow_default" {
	vdc_id = data.basis_vdc.vdc1.id
	name = "Разрешить входящие"
}

resource "basis_network" "network" {
	vdc_id = data.basis_vdc.vdc1.id
	name = "network"

	subnets {
        cidr = "10.20.3.0/24"
        dhcp = true
        gateway = "10.20.3.1"
        start_ip = "10.20.3.2"
        end_ip = "10.20.3.254"
        dns = ["8.8.8.8", "8.8.4.4", "1.1.1.1"]
    }
}

resource "basis_port" "router_port" {
	vdc_id = data.basis_vdc.vdc1.id

	network_id = resource.basis_network.network.id
	ip_address = "10.20.3.11"
	firewall_templates = [data.basis_firewall_template.allow_default.id]
	tags = ["test_port"]
}

```

**Schema. Required:**

*   `network_id` (String) — the network ID.

**Schema. Optional:**

*   `vdc_id` (String) — the VDC ID;
*   `ip_address` (String) — the local IP address of the port;
*   `firewall_templates` (List of String) — the list of ID of firewall profile templates configured on the port;
*   `tags` (Toset, String) — the list of port tags.

**Schema. Read-only:**

*   `id` (String) — the port ID.