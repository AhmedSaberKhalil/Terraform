variable region {
  type = string
  }

variable vpc_cidr {
  type = string
}

variable public_subnet1_cidr {
  type = string
}

variable public_subnet2_cidr {
  type = string
}

variable private_subnet1_cidr {
  type = string
}

variable private_subnet2_cidr {
  type = string
}

variable availability_zone1 {
  type = string
}
variable availability_zone2 {
  type = string
}

variable allow_all {
  type = string
}

variable instance_type {
  type = string
}
variable ami {
  type = string
}

variable key_name {
  type = string
}

variable public_key_secrets_manager_name {
  type = string
} 