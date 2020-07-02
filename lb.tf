#load balancer maybe bastion too instance
resource "openstack_compute_instance_v2" "lb-terraform" {
  name            = "lb-terraform"
  image_id        = "bfbef523-f7d3-462d-aa0a-59d188c6a553"
  flavor_name	  = "m1.c1m1d20"
  key_pair        = "umcloud"
  security_groups = ["sg-terra-lb"]

  #! The floating ip is set on the floatingip.tf file

  network {
    #name = "terra-net"
    name = "${openstack_networking_network_v2.terra-net.name}"
  }
  provisioner "local-exec" {
    command = "echo ${openstack_compute_instance_v2.wp-terraform.access_ip_v4} >> log"
  }
}

resource "null_resource" "remoteexec" {
  #count = 1 
  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      #host = self.access_ip_v4
      host = openstack_networking_floatingip_v2.fip_1.address
      agent = true
  }
  provisioner "remote-exec" {
    inline = [
      #"sudo apt-get update",
      #"sudo apt-get install -y curl",
      "touch Here",
      #"ssh-add",
      "ssh -o StrictHostKeyChecking=no ubuntu@${openstack_compute_instance_v2.wp-terraform.access_ip_v4} 'touch now_here'"
    ]
  }
}
