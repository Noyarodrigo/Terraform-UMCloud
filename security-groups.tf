resource "openstack_networking_secgroup_v2" "sg-terra-app" {
  name        = "sg-terra-app"
}

resource "openstack_networking_secgroup_v2" "sg-terra-lb" {
  name        = "sg-terra-lb"
}

resource "openstack_networking_secgroup_v2" "sg-terra-db" {
  name        = "sg-terra-db"
}

resource "openstack_networking_secgroup_v2" "sg-terra-bastion" {
  name        = "sg-terra-bastion"
}
