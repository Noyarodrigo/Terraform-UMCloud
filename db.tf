#database instance
resource "openstack_compute_instance_v2" "db-terraform" {
  name            = "db-terraform"
  image_id        = "bfbef523-f7d3-462d-aa0a-59d188c6a553"
  flavor_name	  = "m1.c1m1d20"
  key_pair        = "umcloud"
  security_groups = ["sg-terra-db"]

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      host = self.access_ip_v4
      agent = false
  }
  network {
    name = "${openstack_networking_network_v2.terra-net.name}"
  }

  provisioner "file" {
    source = "./scripts/netdatainstaller.sh"
    destination = "/home/ubuntu/wp.sh"
    connection {
      bastion_host = openstack_networking_floatingip_v2.fip_bastion.address
      bastion_user = "ubuntu"
      bastion_private_key = file("/home/roi/.ssh/id_rsa")
      bastion_port = 22

      timeout = "15m"
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      #host = openstack_networking_floatingip_v2.fip_lb.address
      host = self.access_ip_v4
      agent = false 
    }
  }
  provisioner "remote-exec" {
    inline = [
      #"ssh -o StrictHostKeyChecking=no ubuntu@${openstack_compute_instance_v2.wp-terraform.access_ip_v4} 'bash /home/ubuntu/wp.sh'"
    ]
  
    connection {
      bastion_host = openstack_networking_floatingip_v2.fip_bastion.address
      bastion_user = "ubuntu"
      bastion_private_key = file("/home/roi/.ssh/id_rsa")
      bastion_port = 22

      timeout = "15m"
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      #host = openstack_networking_floatingip_v2.fip_lb.address
      host = self.access_ip_v4
      agent = false 
    }
  }
}
