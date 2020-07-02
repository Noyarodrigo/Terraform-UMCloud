#app instance
resource "openstack_compute_instance_v2" "wp-terraform" {
  #count = 1
  #name = "${format("wp-terraform-%d", count.index+1)}"
  name            = "wp-terraform"
  image_id        = "bfbef523-f7d3-462d-aa0a-59d188c6a553"
  flavor_name	  = "m1.c1m1d20"
  key_pair        = "umcloud"
  security_groups = ["sg-terra-app"]
#comentario

  network {
    #name = "terra-net"
    name = "${openstack_networking_network_v2.terra-net.name}"
  }
}

