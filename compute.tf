provider "openstack" {
  user_name   = "r.noya__alumno.um.edu.ar"
  tenant_name = "r.noya__alumno.um.edu.ar"
  domain_name = "default"
  password    = "iw4xdawVktf2gwh3itfl7XWgI1uxbwog"
  auth_url    = "http://keystone.openstack.svc.metal.kube.um.edu.ar:80/v3"
  region      = "RegionOne"
}


resource "openstack_compute_instance_v2" "test-terraform" {
  name            = "test-terraform"
  image_id        = "bfbef523-f7d3-462d-aa0a-59d188c6a553"
  flavor_name	  = "m1.c1m1d20"
  key_pair        = "umcloud"
  security_groups = ["default"]

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/roi/.ssh/id_rsa")
      host = self.access_ip_v4
      agent = false
  }

  network {
    name = "roi-net"
  }

  provisioner "remote-exec"{
    inline = [
	"sudo su",
	"sudo apt-get update",
   ]  
	}
}
