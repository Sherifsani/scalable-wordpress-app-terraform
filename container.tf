resource "aws_ecr_repository" "wordpress_repo" {
  name = "wordpress"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}