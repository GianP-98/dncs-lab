export DEBIAN_FRONTEND=noninteractive
# Startup commands go here
 apt-get update
 apt-get install -y apt-transport-https ca-certificates curl software-properties-common
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
 add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 apt-get update
 apt-get install -y docker-ce

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

echo 'FROM dustnic82/nginx-test  
COPY index.html /usr/share/nginx/html' > Dockerfile

docker build -t my-nginx .
docker run -d --name nginxcontainer -p 8000:80 my-nginx

ip addr add 192.168.33.7/24 dev enp0s8
ip link set enp0s8 up
ip route add default via 192.168.33.1