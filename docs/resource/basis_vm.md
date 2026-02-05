# basis_vm (resource)

> [!NOTE]
> A **server** creation, modification and deletion.

## Usage example

Before using the example, the following must be created:

*   A project named **Terraform Project**;
*   A VDC named **Terraform VDC**;
*   Two disks named **Disk 1** and **Disk 2**.

```hcl
data "basis_project" "single_project" {
    name = "Terraform Project"
}

data "basis_vdc" "single_vdc" {
    project_id = data.basis_project.single_project.id
    name = "Terraform VDC"
}

data "basis_network" "service_network" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Сеть"
}

data "basis_storage_profile" "ssd" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "ssd"
}

data "basis_template" "debian10" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Debian 10"
}

data "basis_firewall_template" "allow_default" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить исходящие"
}

data "basis_firewall_template" "allow_web" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить WEB"
}

data "basis_firewall_template" "allow_ssh" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Разрешить SSH"
}

data "basis_disk" "disk1" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Диск 1"
}

data "basis_disk" "disk2" {
    vdc_id = data.basis_vdc.single_vdc.id
    name = "Диск 2"
}

resource "basis_port" "vm_port" {
    vdc_id = data.basis_vdc.single_vdc.id

    network_id = data.basis_network.service_network.id
    firewall_templates = [data.basis_firewall_template.allow_default.id,
                          data.basis_firewall_template.allow_web.id,
                          data.basis_firewall_template.allow_ssh.id]
}

resource "basis_vm" "vm1" {
    vdc_id = data.basis_vdc.single_vdc.id

    name = "Server 1"
    cpu = 2
    ram = 4

    template_id = data.basis_template.debian10.id

    user_data = file("./user_data.yaml")

    system_disk {
        size = 10
        storage_profile_id = data.basis_storage_profile.ssd.id
    }

    disks = [
        data.basis_disk.disk1.id,
        data.basis_disk.disk2.id,
    ]      
    
    networks {
        id = resource.basis_port.vm_port.id
    } 

    power = true
    floating = false
    tags = ["test"]
}

```

**Schema. Required:**

*   `cpu` (Integer) — the number of virtual CPU of the server.
*   `system_disk` — the primary disk (see nested schema below).
*   `name` (String) — the server name.
*   `ram` (Integer) — the amount of server RAM in GB.
*   `template_id` (String) — the server template ID.
*   `user_data` (String) — the path to the `cloud-init` script file. `Cloud-init` is used for initializing cloud virtual servers on their first boot, allowing automatic server configuration by applying settings passed via metadata. It is recommended to place the script file in the manifest folder. Alternatively, the file content can be added directly to the code block.  
> [!TIP]
> When importing a server, you must specify `user_data = ""` in the manifest, because the script is only applied during server creation.
    
*   `vdc_id` (String) — the VDC ID.

**Schema. Optional:**

*   `networks` (Block List) — a block containing the ID of the port attached to the server. A separate `networks` block is defined for each port (see nested schema below).  
    
    ```hcl
    networks {
    	id = resource.basis_port.vm_port1.id
    }  
    networks {
    	id = resource.basis_port.vm_port2.id
    }  
    
    ```
    
    If needed, a server can be created without network connectivity. In this case, the `networks` block should not be included in the manifest.  
> [!CAUTION]
> After connecting a server to an additional network, in most cases the corresponding network interface in the server OS must be configured manually. Without proper network interface configuration, issues with server network connectivity and Internet accessibility may arise. For example, if a server is connected to multiple networks, each with its own router, and if routers and the server have public IP addresses.
    
> [!NOTE]
> If a server has connections to both an external user network and a local user network, and also has a public IP address assigned, the default route will be through the router in the local network. If no public IP address is assigned, the default route will be set via the first created connection regardless of the network type.
    
*   `floating` (Boolean) — attaches a public IP address to the server. Default is `floating = false`.  
> [!CAUTION]
> If a server with a public IP address is planned to create, the parameter `depends_on = [basis_router.name]` must be set, where `name` is the router name in the network to which the server will be connected.
> If the server is created in the VDC service network, this parameter is optional.
    
*   `platform` (String) — the platform (CPU type) ID.
*   `power` (Boolean) — the server state (`true` — powered on, `false` — powered off). Default is `power = true`.
*   `disks` (Toset, String) — the list of ID of disks attached to the server.
*   `tags` (Toset, String) — the list of server tags.  
> [!TIP]
> When working with BCC version 5.4.0 and higher, users can enable server deletion protection. To do this, add the `deletion_protection` tag to the manifest.
    

**Schema. Read-only:**

*   `floating_ip` (String) — the public IP address attached to the server;
*   `id` (String) — the server ID.

**Nested schema for** `system_disk`**. Required:**

*   `size` (Integer) — the disk size in GB;
*   `storage_profile_id` (String) — the storage profile ID.

**Nested schema for** `system_disk`**. Read-only:**

*   `external_id` (String) — the disk ID in the RUSTACK virtualization platform (for RUSTACK VDC);
*   `id` (String) — the disk ID;
*   `name` (String) — the disk name.

**Nested schema for** `networks`**. Required:**

*   `id` (String) — the port ID.

**Nested schema for** `networks`**. Read-only:**

*   `ip_address` (String) — the port IP address.