output "ecr_repository_uri" {
  value       = aws_ecr_repository.wordpress_repo.repository_url
  description = "The URI of the ECR repository"
}


output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.wordpressdb
  sensitive   = true
}

output "alb_url" {
  description = "value of the ALB URL"
  value = aws_lb.wordpress_alb.dns_name
}