export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=admin''s_password
export OS_AUTH_URL=http://controller:35357/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2

neutron router-create router01 
Router_ID=`neutron router-list | grep router01 | awk '{ print $2 }'` 
neutron net-create int_net --provider:network_type vxlan 

neutron subnet-create --gateway 192.168.30.1 --dns-nameserver 8.8.8.8 int_net 192.168.30.0/24
Int_Subnet_ID=`neutron net-list | grep int_net | awk '{ print $6 }'` 
neutron router-interface-add $Router_ID $Int_Subnet_ID 
neutron net-create ext_net --router:external True --provider:physical_network physnet --provider:network_type flat 

neutron subnet-create ext_net \
--allocation-pool start=172.28.128.200,end=172.28.128.254 \
--gateway 172.28.128.1 --dns-nameserver 8.8.8.8 172.28.128.0/24  --disable-dhcp 
Ext_Net_ID=`neutron net-list | grep ext_net | awk '{ print $2 }'`

neutron router-gateway-set $Router_ID $Ext_Net_ID 
Int_Net_ID=`neutron net-list | grep int_net | awk '{ print $2 }'`

openstack flavor create --id 0 --vcpus 1 --ram 64 --disk 1 m1.nano
openstack server create --flavor m1.nano --image cirros --security-group default --nic net-id=$Int_Net_ID cirros1
neutron floatingip-create ext_net 
Device_ID=`nova list | grep cirros1 | awk '{ print $2 }'`
Port_ID=`neutron port-list -- --device_id $Device_ID | grep ip_address | awk '{ print $2 }'`

Floating_ID=`neutron floatingip-list | grep 172. | awk '{ print $2 }'` 
neutron floatingip-associate $Floating_ID $Port_ID
neutron security-group-rule-create --direction ingress --protocol icmp default 
neutron security-group-rule-create --direction ingress --protocol tcp --port_range_min 22 --port_range_max 22 default 



