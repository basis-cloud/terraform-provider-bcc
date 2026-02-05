# Resources (resource)

> [!TIP]
> Entities available for creation, modification, and management.

> [!NOTE]
> For each resource, it is possible to set timeouts for resource creation and deletion. To do this, specify an additional `timeouts` block in the resource body with the following arguments:
> *   `create` (String) — resource creation timeout;
> *   `delete` (String) — resource deletion timeout.
> 
> If the timeout expires, Terraform will output an error to the console.

> [!NOTE]
> To create certain entities, the `depends_on` parameter must be used. It allows setting dependencies for sequential entity creation. For example, to set the sequence of creating a server and a load balancer with a public IP address only after creating a router.