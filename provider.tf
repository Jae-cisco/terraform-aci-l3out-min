terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "2.2.0"
    }
  }
}

provider "aci" {
  # Configuration options
}
#configure provider with your cisco aci credentials.
provider "aci" {
  # cisco-aci user name
  username = var.username
  # cisco-aci password
  password = var.password
  # cisco-aci url
  url      = var.url
  insecure = true
  #proxy_url = "https://proxy_server:proxy_port"
}
