module "aci_l3out" {
  source  = "qzx/l3out/aci"
  version = "1.0.0"

  name        = "jaheo-example-l3out"
  tenant_name = "jaheo-example"
  vrf         = "jaheo-example-vrf"
  l3_domain   = "jaheo-example-bd"

  paths = {
    primary = {
      name                = "eth1/2"
      pod_id              = 1
      nodes               = [101]
      is_vpc              = false
      vlan_id             = 301
      mtu                 = 1500
      interconnect_subnet = "172.16.0.0/30"
    }
  }

  static_routes = ["0.0.0.0/0"]
}
