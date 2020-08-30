resource "aws_db_instance" "postgres" {
  allocated_storage       = 20 # 20 GB of storage, default for free tier
  engine                  = "postgres"
  engine_version          = "11.6"
  instance_class          = "db.t2.micro" # use micro if you want to use the free tier
  identifier              = "multi-docker"
  name                    = "postgres"
  username                = "postgres"           # username
  password                = "hardsuperpass-word" 
  multi_az                = "false" # set to true to have high availability: 2 instances synchronized with each other
  storage_type            = "gp2"
  backup_retention_period = 30                                          # how long you’re going to keep your backups
  skip_final_snapshot     = true                                        # skip final snapshot when doing terraform destroy
  tags = {
    Name = "postgres-instance"
  }
}

