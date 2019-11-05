export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
 ip addr add 192.168.30.20/23 dev enp0s8
 ip link set enp0s8 up
 ip route add default via 192.168.30.1