#rules for the sg's by their id
resource "openstack_networking_secgroup_rule_v2" "sg-terra-app-egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-app.id}"
}


