export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
sudo ip link add link enp0s8 name enp0s8.10 type vlan id 10       
sudo ip link add link enp0s8 name enp0s8.20 type vlan id 20       
sudo ip addr add 192.168.30.1/23 dev enp0s8.10
sudo ip addr add 192.168.32.1/24 dev enp0s8.20
sudo ip addr add 192.168.34.1/30 dev enp0s9
sudo ip link set enp0s8 up
sudo ip link set enp0s8.10 up
sudo ip link set enp0s8.20 up
sudo ip link set enp0s9 up