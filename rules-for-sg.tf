#rules for the sg's by their id

#APP RULES
#ssh
resource "openstack_networking_secgroup_rule_v2" "sg-terra-app-ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id = "${openstack_networking_secgroup_v2.sg-terra-lb.id}"
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-app.id}"
}
#http
resource "openstack_networking_secgroup_rule_v2" "sg-terra-app-http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_group_id = "${openstack_networking_secgroup_v2.sg-terra-lb.id}"
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-app.id}"
}

#------------
#LB RULES
#SSH
resource "openstack_networking_secgroup_rule_v2" "sg-terra-lb-ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-lb.id}"
}
#HTTP
resource "openstack_networking_secgroup_rule_v2" "sg-terra-lb-http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-lb.id}"
}
#HTTPS
resource "openstack_networking_secgroup_rule_v2" "sg-terra-lb-https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-lb.id}"
}

#------------
#DB RULES
#ssh from lb (security group)
resource "openstack_networking_secgroup_rule_v2" "sg-terra-db-ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id = "${openstack_networking_secgroup_v2.sg-terra-lb.id}"
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-db.id}"
}
#mysql from the app (idem)
resource "openstack_networking_secgroup_rule_v2" "sg-terra-db-mysql" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306 
  port_range_max    = 3306 
  remote_group_id = "${openstack_networking_secgroup_v2.sg-terra-app.id}"
  security_group_id = "${openstack_networking_secgroup_v2.sg-terra-db.id}"
}
