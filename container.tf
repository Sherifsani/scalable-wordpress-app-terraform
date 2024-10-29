resource "aws_ecr_repository" "wordpress_repo" {
  name = "wordpress"

  image_scanning_configuration {
    scan_on_push = true
  }
}