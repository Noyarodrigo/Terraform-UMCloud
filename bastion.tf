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

#si sacas el bastion devolve esto a lb.tf AFUERA del recurso de computo
resource "null_resource" "remoteexec" {
  #count = 1 
  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      #host = openstack_networking_floatingip_v2.fip_lb.address
      host = openstack_networking_floatingip_v2.fip_bastion.address
      agent = true
  }
  provisioner "remote-exec" {
    inline = [
      #"sudo apt-get update",
      "touch Here",
      "ssh -o StrictHostKeyChecking=no ubuntu@${openstack_compute_instance_v2.wp-terraform.access_ip_v4} 'touch now_here'"
    ]
  }
}
