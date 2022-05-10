resource "aci_tenant" "cisco_it_tenant" {
	name        = "terraform-jaheo-tenant"
	description = "ACI Tenant for internal IT"
}

resource "aci_vrf" "cisco_it_vrf" {
	tenant_dn   = "${aci_tenant.cisco_it_tenant.id}"
	name        = "terraform-jaheo-vrf"
}

resource "aci_bridge_domain" "cisco_it_bd" {
	tenant_dn          = "${aci_tenant.cisco_it_tenant.id}"
	relation_fv_rs_ctx = "${aci_vrf.cisco_it_vrf.name}"
	name               = "terraform-jaheo-bd"
}

resource "aci_subnet" "cisco_it_subnet" {
	bridge_domain_dn   = "${aci_bridge_domain.cisco_it_bd.name}"
	name               = "terraform-jaheo-subnet"
	ip                 = "10.23.239.1/22"
}

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
