export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
sudo ip addr add 192.168.33.7/24 dev enp0s8
sudo ip link set enp0s8 up
sudo ip route add default via 192.168.33.1