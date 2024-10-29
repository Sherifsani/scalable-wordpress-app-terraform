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
variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "wordpress_DB"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t4g.micro" # db.t2.micro is supported in the free tier
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "db_username" {
  description = "The database admin username"
  type        = string
}

variable "db_password" {
  description = "The database admin password"
  type        = string
  sensitive   = true
}
