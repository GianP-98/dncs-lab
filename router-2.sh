export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
 ip addr add 192.168.33.1/24 dev enp0s8
 ip addr add 192.168.34.2/30 dev enp0s9
 ip link set enp0s8 up
 ip link set enp0s9 up
 sysctl -w net.ipv4.ip_forward=1
 ip route add 192.168.30.0/23 via 192.168.34.1   
 ip route add 192.168.32.0/24 via 192.168.34.1