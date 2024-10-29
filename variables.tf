variable "public-cidr-ranges" {
  type        = list(string)
  default     = ["10.0.10.0/28", "10.0.20.0/28"]
  description = "Cidr values for the public subnets"
}

variable "private-cidr-ranges" {
  type        = list(string)
  default     = ["10.0.30.0/28", "10.0.40.0/28"]
  description = "Cidr values for the private subnets"

}
variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "Availability zones"
}