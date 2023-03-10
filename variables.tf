variable "create_vpc" {
  description = "decision to create VPC"
  type        = bool
  default     = true
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
    description = "the instance tenancy"
    type = string
    default = "default"
  
}
variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "create_igw" {
  description = "decision to create IGW"
  type        = bool
  default     = false
}



variable "private_subnetcidr" {
    description = "my cidr subnt"
  type = list(any)
  
}
variable "public_subnetcidr" {
    description = "my cidr subnt"
  type = list(any)
  
}

variable "tags" {
     description = "decision to create IGW"
  type        = string
  default     = "allo"
  
}
variable "name" {
     description = "decision to create IGW"
  type        = string
  default     = "allo"
  
}
variable "az" {
     description = "decision to create IGW"
  type        = list(any)
  
}

variable "instance_type" {
         description = "decision to create IGW"
        type        = string
        default     = "allo"
  
}