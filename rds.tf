# DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-private-subnet-group"
  subnet_ids = aws_subnet.private-subnets[*].id

  tags = {
    Name = "RDS Private Subnet Group"
  }
}


resource "aws_db_instance" "wordpressdb" {

  identifier             = "wordpressdb"
  engine                 = var.db_engine
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.RDS_SG.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "wordpress_db"
  }
}

