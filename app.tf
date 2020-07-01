#app instance
resource "openstack_compute_instance_v2" "wp-terraform" {
  name            = "wp-terraform"
  image_id        = "bfbef523-f7d3-462d-aa0a-59d188c6a553"
  flavor_name	  = "m1.c1m1d20"
  key_pair        = "umcloud"
  security_groups = ["sg-terra-app"]

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      host = self.access_ip_v4
      agent = false
  }
  network {
    #name = "terra-net"
    name = "${openstack_networking_network_v2.terra-net.name}"
  }
}
