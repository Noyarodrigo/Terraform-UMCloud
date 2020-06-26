#from the lb to the app
resource "openstack_networking_secgroup_v2" "sg-terra-app" {
  name        = "sg-terra-app"
}

#internet to the load balancer
resource "openstack_networking_secgroup_v2" "sg-terra-lb" {
  name        = "sg-terra-lb"
}

#from the app to de database
resource "openstack_networking_secgroup_v2" "sg-terra-db" {
  name        = "sg-terra-db"
}
