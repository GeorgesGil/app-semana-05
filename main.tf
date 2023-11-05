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
  image    = "docker-20-04"
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
    "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 35696F43FC7DB4C2",
    "sudo killall apt apt-get",
    "sudo ufw allow 1339",
    "sudo ufw allow 443",
    "sudo ufw allow 5432",
    "sudo ufw allow 5433",
    "sudo ufw allow 8000",
    "sudo rm /var/lib/apt/lists/lock",
    "sudo rm /var/cache/apt/archives/lock",
    "sudo rm /var/lib/dpkg/lock*",
    "sudo dpkg --configure -a",
    "sudo apt-get update",
    "sudo apt install -y git",
    "git clone https://github.com/GeorgesGil/app-semana-05.git",
    "cd app-semana-05/db-app",
    "docker-compose --version",
    "docker network create mynetwork",
    "docker-compose up -d --build",
    "docker container ls",
    "cd ../nginx-app",
    "docker-compose --version",
    "docker-compose up -d --build",
    "docker container ls",
    "sudo apt-get install -y postgresql-client",
  ]
}


}
