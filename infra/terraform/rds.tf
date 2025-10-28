############################
# RDS SUBNET GROUP
############################
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-subnet-group"
  description = "Subnets for RDS"
  subnet_ids  = module.vpc.private_subnets # from VPC module

  tags = {
    Name = "rds-subnet-group"
  }
}

############################
# RDS SECURITY GROUP
############################
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from EKS worker nodes"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "From EKS node SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

############################
# RDS INSTANCE
############################
resource "aws_db_instance" "mysql" {
  identifier        = "my-mysql-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = 20

  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name # ADDED
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "my-mysql-db"
  }
}

