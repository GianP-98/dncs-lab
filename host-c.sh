export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker
touch Dockerfile
echo '
FROM ubuntu 
RUN apt-get update 
RUN apt-get install nginx -y 
COPY index.html /var/www/html/ 
EXPOSE 80 
CMD ["nginx","-g","daemon off;"]' > Dockerfile
echo '
<html>
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
sudo docker build -t nginx .
sudo docker run -d --name nginxcontainer -p 8000:80 nginx
sudo ip addr add 192.168.33.7/24 dev enp0s8
sudo ip link set enp0s8 up
sudo ip route add default via 192.168.33.1

