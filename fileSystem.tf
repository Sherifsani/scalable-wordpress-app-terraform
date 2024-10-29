resource "aws_efs_file_system" "wordpress_efs" {
  creation_token   = "wordpress_efs"
  performance_mode = "generalPurpose"

  tags = {
    Name = "wordpress_efs"
  }
}

resource "aws_efs_mount_target" "wordpress_mount_target" {
  count           = length(var.azs)
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = aws_subnet.private-subnets[count.index].id
  security_groups = [aws_security_group.EFS_SG.id]
}