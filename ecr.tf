
resource "aws_ecr_repository" "multi-client" {
  name                 = "multi-client"
  image_tag_mutability = "MUTABLE"
  }

resource "aws_ecr_repository" "multi-server" {
  name                 = "multi-server"
  image_tag_mutability = "MUTABLE"
  }

resource "aws_ecr_repository" "multi-nginx" {
  name                 = "multi-nginx"
  image_tag_mutability = "MUTABLE"
  }

resource "aws_ecr_repository" "multi-worker" {
  name                 = "multi-worker"
  image_tag_mutability = "MUTABLE"
  }


