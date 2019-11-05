export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
 ip link add link enp0s8 name enp0s8.10 type vlan id 10       
 ip link add link enp0s8 name enp0s8.20 type vlan id 20       
 ip addr add 192.168.30.1/23 dev enp0s8.10
 ip addr add 192.168.32.1/24 dev enp0s8.20
 ip addr add 192.168.34.1/30 dev enp0s9
 ip link set enp0s8 up
 ip link set enp0s8.10 up
 ip link set enp0s8.20 up
 ip link set enp0s9 up
 sysctl -w net.ipv4.ip_forward=1
 ip route add 192.168.33.0/24 via 192.168.34.2