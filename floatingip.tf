#create the public ip from the pool ext_net
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "ext_net"
}

#get the address and associate it with the instance (fip => instance_id)
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.wp-terraform.id}"
}
