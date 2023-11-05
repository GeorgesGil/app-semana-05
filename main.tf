terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "digitalocean" {
  token = var.token
}



resource "digitalocean_droplet" "web2" {
  image    = "ubuntu-20-04-x64"
  name     = "server2"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_fingerprint]



  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.private_key)
    timeout     = "2m"
  }


provisioner "remote-exec" {
    inline = [
    "export DEBIAN_FRONTEND=noninteractive",
    "apt-get update",
    "sudo ufw allow 8080",
    "sudo ufw allow 1339",
    "sudo ufw allow 443",
    "sudo ufw allow 5432",
    "sudo ufw allow 5433",
    "sudo ufw allow 8000",
    "apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
    "apt-get update",
    "docker --version", 
    "sudo apt install -y git",
    "git clone https://github.com/GeorgesGil/app-semana-05.git",
    "cd app-semana-05/db-app",
    "curl -L https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
    "chmod +x /usr/local/bin/docker-compose",
    "docker-compose --version",
    "docker network create mynetwork",
    "docker-compose up -d --build",
    "docker container ls",
    "cd ../nginx-app",
    "docker-compose up -d --build",
    "docker container ls",
    "sudo apt-get install -y postgresql-client",
  ]
}






}



# funciono

# provisioner "remote-exec" {
#     inline = [
#     "export DEBIAN_FRONTEND=noninteractive",
#     "apt-get update",
#     "sudo ufw allow 8080",
#     "sudo ufw allow 1339",
#     "sudo ufw allow 443",
#     "sudo ufw allow 5432",
#     "sudo ufw allow 5433",
#     "sudo ufw allow 8000",
#     "apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
#     "apt-get update",
#     "docker --version", 
#     "sudo apt install -y git",
#     "git clone https://github.com/GeorgesGil/app-semana-05.git",
#     "cd app-semana-05/db-app",
#     "curl -L https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
#     "chmod +x /usr/local/bin/docker-compose",
#     "docker-compose --version",
#     "docker network create mynetwork",
#     "docker-compose up -d --build",
#     "docker container ls",
#     "cd ../nginx-app",
#     "docker-compose up -d --build",
#     "docker container ls",
#     "sudo apt-get install -y postgresql-client",
#   ]
# }