

# cluster
resource "aws_ecs_cluster" "multi-docker" {
  name = "multi-docker"
}

resource "aws_launch_configuration" "multi-docker-launchconfig" {
  name_prefix          = "multi-docker-launchconfig"
  image_id             = var.ECS_AMIS[var.AWS_REGION]
  instance_type        = var.ECS_INSTANCE_TYPE
  key_name             = aws_key_pair.ecs-key.key_name
  iam_instance_profile = aws_iam_instance_profile.sandbox-exec-role.id
  security_groups      = [aws_security_group.db-redis-sg.id,aws_security_group.http-sg.id]
  user_data            = "#!/bin/bash\n echo 'ECS_CLUSTER=multi-docker' >> /etc/ecs/ecs.config\n start ecs"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "multi-docker-asg" {
  name                 = "multi-docker-asg"
  launch_configuration = aws_launch_configuration.multi-docker-launchconfig.name
  availability_zones = ["eu-central-1b", "eu-central-1a", "eu-central-1c"]
  min_size             = 2
  max_size             = 2
  tag {
    key                 = "Name"
    value               = "ecs-multi-docker"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "multi-docker-asg" {
  autoscaling_group_name = aws_autoscaling_group.multi-docker-asg.id
  elb                    = aws_elb.elb-multi-docker.id
}

resource "aws_elb" "elb-multi-docker" {
  name = "elb-multi-docker"
  availability_zones = ["eu-central-1b", "eu-central-1a", "eu-central-1c"]
 
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300
  security_groups = [aws_security_group.http-sg.id]
  
  tags = {
    Name = "elb-multi-docker"
  }
}

