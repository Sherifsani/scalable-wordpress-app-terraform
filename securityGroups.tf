resource "aws_security_group" "EFS_SG" {
  name        = "EFS_SG"
  description = "Allows NFS traffic on the Elastic File System"
  vpc_id      = aws_vpc.wordpress.id

  tags = {
    Name = "EFS_SG"
  }
}

resource "aws_security_group" "RDS_SG" {
  name        = "RDS_SG"
  description = "Allows MySQL/MariaDB traffic on the RDS instance"
  vpc_id      = aws_vpc.wordpress.id

  tags = {
    Name = "RDS_SG"
  }
}

resource "aws_security_group" "ECS_SG" {
  name        = "ECS_SG"
  description = "Allows HTTP and HTTPS traffic on the Fargate tasks"
  vpc_id      = aws_vpc.wordpress.id

  tags = {
    Name = "ECS_SG"
  }
}

# Allow NFS traffic from ECS_SG to EFS_SG
resource "aws_security_group_rule" "allow_NFS_from_ECS" {
  type                     = "ingress"
  security_group_id        = aws_security_group.EFS_SG.id
  source_security_group_id = aws_security_group.ECS_SG.id
  protocol                 = "tcp"
  from_port                = 2049
  to_port                  = 2049
}

# Allow MySQL traffic from ECS_SG to RDS_SG
resource "aws_security_group_rule" "allow_MySQL_from_ECS" {
  type                     = "ingress"
  security_group_id        = aws_security_group.RDS_SG.id
  source_security_group_id = aws_security_group.ECS_SG.id
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
}

# Allow HTTP traffic from anywhere to ECS_SG
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  security_group_id = aws_security_group.ECS_SG.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
}

# Allow HTTPS traffic from anywhere to ECS_SG
resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  security_group_id = aws_security_group.ECS_SG.id
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
}
