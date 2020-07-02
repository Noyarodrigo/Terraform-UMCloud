#devolver esto a lb.tf AFUERA del recurso de computo si no anda
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
