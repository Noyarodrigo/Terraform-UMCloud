resource "openstack_networking_network_v2" "terra-net" {
  name           = "terra-net"
}

resource "openstack_networking_subnet_v2" "terra-subnet" {
  name       = "terra-subnet"
  cidr		= "172.20.0.0/24"
  network_id = "${openstack_networking_network_v2.terra-net.id}" 
  ip_version = 4
}

resource "openstack_networking_router_v2" "terra-router-ext" {
  name             = "terra-router-ext"
  external_network_id = "bd720adf-4413-4135-b6e5-9c15f37f8e51" 
}

resource "openstack_networking_router_interface_v2" "interfaz" {
  router_id = "${openstack_networking_router_v2.terra-router-ext.id}"
  subnet_id = "${openstack_networking_subnet_v2.terra-subnet.id}"
}
