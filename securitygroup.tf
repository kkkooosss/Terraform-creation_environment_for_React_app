resource "aws_security_group" "db-redis-sg" {
  name        = "db-redis-sg"
  description = "security group for postgres&redis"
  depends_on  = [aws_security_group.http-sg]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.http-sg.id]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.http-sg.id]
  }
  tags = {
    Name = "db-redis-sg"
  }
}

resource "aws_security_group" "http-sg" {
  name        = "http-sg"
  description = "security group for elb-multi-docker"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elb-multi-docker"
  }
}

