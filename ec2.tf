provider "aws" {
  region              = "eu-west-1"
}

resource "aws_lb" "loki-lb" {
  name                = "loki-lb"
  internal            = false
  load_balancer_type  = "application"
  subnets             = ["subnet-2687ba6f","subnet-f29befa9"]
#  enable_deletion_protection = true

  tags {
    Environment       = "Development"
  }

}

resource "aws_instance" "loki-ec2" {
  ami                     = "ami-396a1640"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = ["sg-8b7ad7f6"]
  subnet_id               = "subnet-be86bbf7"

  tags {
    Name = "loki-instance"
  }

}

resource "aws_db_instance" "loki-rds" {
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "9.3.20"
  instance_class          = "db.t2.micro"
  name                    = "lokirds"
  username                = "lokiuser"
  password                = "lokipassword"
  db_subnet_group_name    = "subnet-4e87ba07"
}