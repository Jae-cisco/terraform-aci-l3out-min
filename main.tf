module "aci_l3out" {
  source  = "qzx/l3out/aci"
  version = "1.0.0"

  name        = "Cisco-terraform-test-l3out"
  tenant_name = "jaheo-terraform-test"
  vrf         = "jaheo-terraform-test-vrf1"
  l3_domain   = "jaheo-example-l3domain"

  paths = {
    primary = {
      name                = "eth1/2"
      pod_id              = 1
      nodes               = [101]
      is_vpc              = false
      vlan_id             = 301
      mtu                 = 1500
      interconnect_subnet = "172.16.250.1/30"
    }
  }
  
  bgp_peers = {
    primary = {
      address   = "172.16.250.1"
      local_as  = 10
      remote_as = 200
      password  = "provider-password-1"
    }
  }
  #static_routes = ["0.0.0.0/0"]
}
