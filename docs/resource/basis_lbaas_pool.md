# basis_lbaas_pool (resource)

> [!NOTE]
> A **load balancer pool** creation, modification and deletion.

> [!CAUTION]
> When importing the entity, specific considerations must be taken into account.

## Usage example

```hcl
data "basis_project" "single_project" {
	name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
	project_id = data.basis_project.single_project.id
	name = "Terraform VDC"
}

data "basis_template" "debian10" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Debian 10"
}

data "basis_network" "service_network" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Сеть"
}

data "basis_firewall_template" "allow_default" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить входящие"
}

data "basis_storage_profile" "ssd" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "ssd"
}


resource "basis_port" "vm_port" {
    vdc_id = data.basis_vdc.single_vdc.id

    network_id = data.basis_network.service_network.id
    firewall_templates = [data.basis_firewall_template.allow_default.id]
}

resource "basis_vm" "vm" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Server 1"
    cpu = 3
    ram = 3
    power = true

    template_id = data.basis_template.debian10.id

    user_data = "${file("user_data.yaml")}"

    system_disk {
        size = 10
        storage_profile_id = data.basis_storage_profile.ssd.id
    }

    networks {
        id = resource.basis_port.vm_port.id
    }

    floating = true
}


resource "basis_lbaas" "lbaas" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "lbaas"
    floating = true
    port {
        network_id = data.basis_network.service_network.id
    }
}

resource "basis_lbaas_pool" "pool" {
    lbaas_id = resource.basis_lbaas.lbaas.id
    connlimit = 34
    method = "SOURCE_IP"
    protocol = "TCP"
    port = 80

    member {
        port = 80
        weight = 50
        vm_id = resource.basis_vm.vm.id
    }

    depends_on = [basis_vm.vm]
}

```

**Schema. Required:**

*   `lbaas_id` (String) — the load balancer ID to which the pool is connected;
*   `port` (String) — the load balancer port through which the pool is accessible;
*   `method` (String) — the load balancing method, it can be: `ROUND_ROBIN`, `LEAST_CONNECTIONS`, `SOURCE_IP`;
*   `protocol` (String) — the traffic balancing protocol, it can be: `TCP`, `HTTP`, `HTTPS`;
*   `member` (Schema) — a pool member, a separate block is defined for each member (see nested schema below).  
> [!CAUTION]
> When creating a load balancer pool, it is necessary to add the parameter `depends_on = [basis_vm.vm]`, where `vm` is the name of the server member of the pool.
    

**Schema. Optional:**

*   `connlimit` (Integer) — the connection limit for the pool;
*   `session_persistence` (String) — load balancer session persistence, it can be: `APP COOKIE`, `HTTP COOKIE`, `Source IP`.

**Nested schema for `member`. Required:**

*   `port` (Integer) — the member's port;
*   `vm_id` (String) — the server member ID.

**Nested schema for** `member`**. Optional:**

*   `weight` (Integer) — the member's weight.