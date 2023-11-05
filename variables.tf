variable "token" {
    type        = string
    description = "DigitalOcean API Token"
    default     = ""
}

variable "ssh_fingerprint" {
    type        = string
    description = "Public Key"
    default     = ""
}

variable "public_key" {
    type = string
    description = "Public Key"
    default = ""
}
variable "private_key" {
    type = string
    description = "Private Key"
    default =  ""
}