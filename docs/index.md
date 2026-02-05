# Quick Start

The provider is used for interaction between Terraform/OpenTofu and a cloud managed by BCC. To achieve this, the provider utilizes the BCC's API.

To authorize the provider, appropriate credentials must be provided.

## Initialization example:

```hcl
terraform {
  required_providers {
    basis = {
      source  = "registry.opentofu.org/basis-cloud/bcc" # or registry.terraform.io/basis-cloud/bcc
      version = ">= 2.2.0"
    }
  }
}

provider "basis" {
    api_endpoint = "URL of the cloud platform API"
    token = "Cloud platform user token"
    insecure = true
}

```

**Schema. Required:**

*   `api_endpoint` (String) — URL of the cloud platform API, e.g., https://dev.cloud.online;
*   `token` (String) — user token for API operations.

**Schema. Optional:**

*   `ca_cert` — the content of the certificate file or the path to the root certificate, e.g., `file("./root-ca.crt")`;
*   `cert` — the content of the certificate file or the path to the client or intermediate certificate, e.g., `file("./client.crt")`;
*   `cert_key` — the content of the key file or the path to the client certificate key, e.g., `file("./key.crt")`;
*   `insecure` — allows connecting to the BCC without TLS certificate verification. The default value is `false`. With `insecure = true`, an insecure connection is established. When certificates are added, the `insecure` parameter is ignored.