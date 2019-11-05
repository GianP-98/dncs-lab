export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

echo '<html>
<head>
<title>Progetto Arnoldi</title> 
<style>
 h1 {text-align:center; color:blue}
 p {text-align:center;}
 img {display: block;
  margin-left: auto;
  margin-right: auto;
  width: 40%;}
</style>
</head>
<body>
<h1>Gianluca Pilati</h1>
<p>Ingegneria dell informazione e comunicazioni</p>
</body>
</html>
'> index.html

echo 'FROM dustnic82/nginx-test  
COPY index.html /usr/share/nginx/html' > Dockerfile

sudo docker build -t my-nginx .
sudo docker run -d --name nginxcontainer -p 8000:80 my-nginx

sudo ip addr add 192.168.33.7/24 dev enp0s8
sudo ip link set enp0s8 up
sudo ip route add default via 192.168.33.1