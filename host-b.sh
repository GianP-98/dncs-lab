export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
 ip addr add 192.168.32.10/24 dev enp0s8
 ip link set enp0s8 up
 ip route add default via 192.168.32.1