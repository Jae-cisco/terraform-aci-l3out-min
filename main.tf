

resource "aci_tenant" "terraform_ten" {
  name = "terraform_ten"
}

resource "aci_vrf" "vrf1" {
  tenant_dn = "${aci_tenant.terraform_ten.id}"
  name      = "vrf1"
}

resource "aci_bridge_domain" "bd1" {
  tenant_dn          = "${aci_tenant.terraform_ten.id}"
  relation_fv_rs_ctx = "${aci_vrf.vrf1.name}"
  name               = "bd1"
}

resource "aci_subnet" "bd1_subnet" {
  bridge_domain_dn = "${aci_bridge_domain.bd1.id}"
  name             = "Subnet"
  ip               = "192.168.1.1/24"
}

#module "aci_tenant" {
 # source  = "qzx/tenant/aci"
 # version = "1.0.0"

#  tenant_name = "terraform-jaheo"
#}

module "aci_l3out" {
  source  = "qzx/l3out/aci"
  version = "1.0.0"

  name        = "jaheo-example-l3out"
  tenant_name = "jaheo-example"
  vrf         = "jaheo-example-vrf"
  l3_domain   = "jaheo-example-l3domain"

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
