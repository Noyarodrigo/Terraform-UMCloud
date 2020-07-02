#create the public ip from the pool ext_net
resource "openstack_networking_floatingip_v2" "fip_lb" {
  pool = "ext_net"
}

#get the address and associate it with the lb instance (fip => instance_id)
resource "openstack_compute_floatingip_associate_v2" "fip_lb" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_lb.address}"
  instance_id = "${openstack_compute_instance_v2.lb-terraform.id}"
}

#para el bastion, si no se usa comentar/borrar
#create fip for the bastion
resource "openstack_networking_floatingip_v2" "fip_bastion" {
  pool = "ext_net"
}

#get the address and associate it with the bastion instance (fip => instance_id)
resource "openstack_compute_floatingip_associate_v2" "fip_bastion" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_bastion.address}"
  instance_id = "${openstack_compute_instance_v2.bastion-terraform.id}"
}
