export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
sudo ip addr add 192.168.33.1/24 dev enp0s8
sudo ip addr add 192.168.34.2/30 dev enp0s9
sudo ip link set enp0s8 up
sudo ip link set enp0s9 up