# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```


        +-----------------------------------------------------+
        |                                                     |
        |                                                     |eth0
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |            eth0|            |eth2     eth2|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |eth1                       |eth1
        |  N  |                      |                           |
        |  A  |                      |                           |
        |  G  |                      |                     +-----+----+
        |  E  |                      |eth1                 |          |
        |  M  |            +-------------------+           |          |
        |  E  |        eth0|                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |eth2         |eth3                |eth0
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |eth1         |eth1                |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |    eth0|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |eth0                   |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

# Requirements
 - Python 3
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/dustnic/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab] vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 4 VMs
 ```
 [dncs-lab]$ vagrant status                                                                                                                                                                
Current machine states:

router                    running (virtualbox)
switch                    running (virtualbox)
host-a                    running (virtualbox)
host-b                    running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router`
`vagrant ssh switch`
`vagrant ssh host-a`
`vagrant ssh host-b`
`vagrant ssh host-c`

# Assignment
This section describes the assignment, its requirements and the tasks the student has to complete.
The assignment consists in a simple piece of design work that students have to carry out to satisfy the requirements described below.
The assignment deliverable consists of a Github repository containing:
- the code necessary for the infrastructure to be replicated and instantiated
- an updated README.md file where design decisions and experimental results are illustrated
- an updated answers.yml file containing the details of 

## Design Requirements
- Hosts 1-a and 1-b are in two subnets (*Hosts-A* and *Hosts-B*) that must be able to scale up to respectively 355 and 229 usable addresses
- Host 2-c is in a subnet (*Hub*) that needs to accommodate up to 246 usable addresses
- Host 2-c must run a docker image (dustnic82/nginx-test) which implements a web-server that must be reachable from Host-1-a and Host-1-b
- No dynamic routing can be used
- Routes must be as generic as possible
- The lab setup must be portable and executed just by launching the `vagrant up` command

## Tasks
- Fork the Github repository: https://github.com/dustnic/dncs-lab
- Clone the repository
- Run the initiator script (dncs-init). The script generates a custom `answers.yml` file and updates the Readme.md file with specific details automatically generated by the script itself.
  This can be done just once in case the work is being carried out by a group of (<=2) engineers, using the name of the 'squad lead'. 
- Implement the design by integrating the necessary commands into the VM startup scripts (create more if necessary)
- Modify the Vagrantfile (if necessary)
- Document the design by expanding this readme file
- Fill the `answers.yml` file where required (make sure that is committed and pushed to your repository)
- Commit the changes and push to your own repository
- Notify the examiner that work is complete specifying the Github repository, First Name, Last Name and Matriculation number. This needs to happen at least 7 days prior an exam registration date.

# Notes and References
- https://rogerdudler.github.io/git-guide/
- http://therandomsecurityguy.com/openvswitch-cheat-sheet/
- https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
- https://www.vagrantup.com/intro/getting-started/


# Design
- `First Name:` Gianluca 
- `Last Name:` Pilati
- `Matriculation number:` 193731 


## Subnets
The network is made by 4 subnets (Hosts-A, Hosts-B, Hub and the one between the routers). They have to scale up to respectively 355, 229, 246 and 2 usable addresses.
The `netmasks` for this task are:
```
Hosts-A:                255.255.254.0
Hosts-B:                255.255.255.0
Hub:                    255.255.255.0
Routers:                255.255.255.252
```
The choice to use that netmask for the `Routers` network prevents us from increasing the number of hosts in the future without changing the IP address. 
I decided to use 192.168.x.x class for every subnet. So, in the end, we have the following assignements:

|    Network    |        Netmask        |   Network address  | 
|:-------------:|:---------------------:|:------------------:|
|   **Hosts-A** |     255.255.254.0     |    192.168.30.0    |
|   **Hosts-B** |     255.255.255.0     |    192.168.32.0    | 
|     **Hub**   |     255.255.255.0     |    192.168.33.0    |
|   **Routers** |     255.255.255.252   |    192.168.34.0    |

## IP Addresses
I gave to the effective hosts in the subnets their IP addresses. The assignments are the following: 

|      Host     |      IP Address       |
|:-------------:|:---------------------:|
|   **host-a**  |     192.168.30.20     |
|   **host-b**  |     192.168.32.10     |
|   **host-c**  |     192.168.33.7      |

For the routers there are some differences:
- The routers need to have two ports activated, so they required two different IP addresses.
- The port enp0s8 of the router-1 is linked to the switch by a "particular port" because the networks Hosts-A and Hosts-B are separated by two `VLANs` that I explain in the next paragraph. 

In conclusion, the assignments for the routers are the following:

|    Router     |      IP Address       |     Port    |
|:-------------:|:---------------------:|:-----------:| 
|  **router-1** |     192.168.30.1      |   enp0s8.10 |
|  **router-1** |     192.168.32.1      |   enp0s8.20 |
|  **router-1** |     192.168.34.1      |    enp0s9   |
|  **router-2** |     192.168.33.1      |    enp0s8   |
|  **router-2** |     192.168.34.2      |    enp0s9   |

The command used to assign the IP address to a port of a host/router is:
```
ip addr add <ip address>/<subnetmask> dev <port name>
```
Then the port has to set `up` to be activated:
```
ip link set <port name> up
```
## Vlans

Like I said before the networks Hosts-A and Hosts-B are separated by two Vlans. This means that the enp0s8 port of the router-1 requires to manage all the traffic of the two VLANs in only one physic port of the router; we can say that the port is divided into two different `logic ports`. This kind of ports is called `trunk links`.
The command used in the router-1 to make the trunk:
```
ip link add link <port name> name <vlan name> type vlan id <id number>
```

We need to configure also the switch for separate the traffic of the two networks in it. This is made by this simple command:
```
ovs-vsctl add-port switch <port name> tag=<vlan tag>
```
So the switch has three port activated(up), the enp0s9 and enp0s10 are the direct links with the hosts and the enp0s8 is the trunk connected with the router-1:

|     Port    |        Type       |
|:-----------:|:-----------------:|
|    enp0s8   |       trunk       |
|    enp0s9   |       access      |
|    enp0s10  |       access      |

## Routing
The task ask for the most generic routes possible, so I decided to set only the default gateway for hosts. This can be done simply with:
```
ip route add default via <ip address of default gateway>
```
With this command, all the packets sent by a host will be passed through the chosen default gateway. But even the router has to know the next hop and this is made by this command:
```
ip route add <network ip address>/<netmask> via <next hop ip address>
```
this means that every packet that arrive by the network with the ip address chosen in the command will be sent through the port that is connected with the next-hop ip address.
At the end the routing tables are theese:

### router-1

|         Desination         |        Next Hop   (Port)     |
|:--------------------------:|:----------------------------:|
|       192.168.33.0/24      |     192.168.34.2  (enp0s9)   |

### router-2

|         Desination         |        Next Hop   (Port)     |
|:--------------------------:|:----------------------------:|
|       192.168.30.0/23      |     192.168.34.1  (enp0s9)   |
|       192.168.32.0/24      |     192.168.34.1  (enp0s9)   |
```
host-a default gateway is 192.168.30.1
host-b default gateway is 192.168.32.1
host-c default gateway is 192.168.33.1
```

## Docker
The host-c must run a docker image which implements a web-server.
Theese commands are needed to install docker:
```
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
```

I decided to create a personalized html page for the web server:
```
echo '<html>
<head>
<title>Progetto</title> 
<style>
 h1 {text-align:center; color:blue}
 p {text-align:center;}
</style>
</head>
<body>
<h1>Gianluca Pilati</h1>
<p>Ingegneria dell informazione e comunicazioni</p>
<p>Matricola: 193731</p>
</body>
</html>
'> index.html
```
For configure docker there are two ways: by commads or create a Docker File. I choose the second option:
```
echo 'FROM dustnic82/nginx-test  
COPY index.html /usr/share/nginx/html' > Dockerfile

docker build -t my-nginx .
```
In conclusion this command run the nginx-container on port 8000 of the host-c:
```
docker run -d --name nginxcontainer -p 8000:80 my-nginx
```

## Conclusion
For create all the virtual machines needed the first command to insert in the terminal is:
```
vagrant up
```
To see if the web-server run on the host-c is reachable by host-a and host-b:
```
vagrant ssh <host-a or host-b>
```
by terminal and then:
```
vagrant@host-a:~$ curl 192.168.33.7:8000
<html>
<head>
<title>Progetto</title>
<style>
 h1 {text-align:center; color:blue}
 p {text-align:center;}
</style>
</head>
<body>
<h1>Gianluca Pilati</h1>
<p>Ingegneria dell informazione e comunicazioni</p>
<p>Matricola: 193731</p>
</body>
</html>
```

As the task ask, every host is reachable by the others:
```
vagrant@host-a:~$ ping 192.168.33.7
PING 192.168.33.7 (192.168.33.7) 56(84) bytes of data.
64 bytes from 192.168.33.7: icmp_seq=1 ttl=62 time=1.87 ms
64 bytes from 192.168.33.7: icmp_seq=2 ttl=62 time=1.37 ms
64 bytes from 192.168.33.7: icmp_seq=3 ttl=62 time=1.27 ms
^C
--- 192.168.33.7 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.274/1.506/1.874/0.263 ms

---------------------------------------------------------------

vagrant@host-a:~$ ping 192.168.32.1
PING 192.168.32.1 (192.168.32.1) 56(84) bytes of data.
64 bytes from 192.168.32.1: icmp_seq=1 ttl=64 time=0.955 ms
64 bytes from 192.168.32.1: icmp_seq=2 ttl=64 time=0.688 ms
64 bytes from 192.168.32.1: icmp_seq=3 ttl=64 time=0.645 ms
^C
--- 192.168.32.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 0.645/0.762/0.955/0.140 ms
```