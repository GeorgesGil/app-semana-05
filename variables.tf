variable "token" {
    type        = string
    description = "DigitalOcean API Token"
}

variable "ssh_fingerprint" {
    type        = string
    description = "Public Key"
}

variable "public_key" {
    type = string
    description = "Public Key"
}
variable "private_key" {
    type = string
    description = "Private Key"
}