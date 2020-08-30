
resource "aws_ecs_task_definition" "multi-docker-task-definition" {
  family = "multi-docker-task-definition"
  container_definitions = <<EOF
  [
    {
      "name": "client",
      "image": "kkkooosss/multi-client",
      "memory": 128,
      "hostname": "client",
      "portMappings": [],
      "essential": false
    },
    {
      "name": "server",
      "image": "kkkooosss/multi-server",
      "memory": 128,
      "hostname": "api",
      "portMappings": [],
      "essential": false,
      "environment": [
        {
          "name": "PGDATABASE",
          "value": "POSTGRES_DB"
        },
        {
          "name": "PGHOST",
          "value": "POSTGRESS_HOST"
        },
        {
          "name": "PGPASSWORD",
          "value": "POSTGRES_PASSWORD"
        },
        {
          "name": "PGPORT",
          "value": "5432"
        },
        {
          "name": "PGUSER",
          "value": "POSTGRES_USER"
        },
        {
          "name": "REDIS_HOST",
          "value": "REDIS_ENDPOINT"
        },
        {
          "name": "REDIS_PORT",
          "value": "6379"
        }
      ]
    },
    {
      "name": "worker",
      "image": "kkkooosss/multi-worker",
      "memory": 128,
      "hostname": "worker",
      "portMappings": [],
      "essential": false,
      "environment": [
        {
          "name": "REDIS_HOST",
          "value": "REDIS_ENDPOINT"
        },
        {
          "name": "REDIS_PORT",
          "value": "6379"
        }
      ]
    },
    {
      "name": "nginx",
      "image": "kkkooosss/multi-nginx",
      "memory": 128,
      "hostname": "nginx",
      "essential": true, 
      "links": [
        "client",
        "server"
      ],
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": 80
        }
      ]
    }
  ]    
EOF
}

resource "aws_ecs_service" "multi-docker-service" {
  name            = "multi-docker-service"
  cluster         = aws_ecs_cluster.multi-docker.id
  task_definition = aws_ecs_task_definition.multi-docker-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_role.sandbox-exec-role]

  load_balancer {
    elb_name       = aws_elb.elb-multi-docker.name
    container_name = "nginx"
    container_port = 80
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}

