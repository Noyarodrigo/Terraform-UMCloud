#test for spliting load balancer and bastion in 2 instances
#bastion instance

resource "openstack_compute_instance_v2" "bastion-terraform" {
  name            = "bastion-terraform"
  image_id        = "bfbef523-f7d3-462d-aa0a-59d188c6a553"
  flavor_name	  = "m1.c1m1d20"
  key_pair        = "umcloud"
  security_groups = ["sg-terra-bastion"]

  network {
    name = "${openstack_networking_network_v2.terra-net.name}"
  }
}
