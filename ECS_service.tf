# ECS Service with ALB Integration
resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.wordpress_cluster.arn
  task_definition = aws_ecs_task_definition.wordpress_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private-subnets[*].id
    security_groups  = [aws_security_group.ECS_SG.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.wordpress_tg.arn
    container_name   = "my-container"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http_listener]
}