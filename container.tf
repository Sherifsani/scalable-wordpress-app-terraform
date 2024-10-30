# Repository for the wordpress image
resource "aws_ecr_repository" "wordpress_repo" {
  name = "wordpress"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}

# ECS cluster 
resource "aws_ecs_cluster" "wordpress_cluster" {
  name = "wordpress_cluster"
}

# Create an IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AmazonECSTaskExecutionRolePolicy to the Role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition (using Fargate)
resource "aws_ecs_task_definition" "wordpress_task" {
  family                   = "wordpress_task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "my-container",
    "image": "my-image",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
"environment": [
  {
    "name": "WORDPRESS_DB_HOST",
    "value": "${aws_db_instance.wordpressdb.address}"
  },
  {
    "name": "WORDPRESS_DB_USER",
    "value": "${aws_db_instance.wordpressdb.username}"
  },
  {
    "name": "WORDPRESS_DB_PASSWORD",
    "value": "${aws_db_instance.wordpressdb.password}"
  },
  {
    "name": "WORDPRESS_DB_NAME",
    "value": "${aws_db_instance.wordpressdb.db_name}"
  }
],

    "mountPoints": [
      {
        "sourceVolume": "my-efs-volume",
        "containerPath": "/var/www/html"
      }
    ]
  }
]
DEFINITION

  # Define the EFS Volume
  volume {
    name = "my-efs-volume"

    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.wordpress_efs.id
      transit_encryption = "ENABLED"
      root_directory     = "/"
    }
  }
}

