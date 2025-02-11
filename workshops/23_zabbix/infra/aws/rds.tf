#------------------------
# RDS INSTANCES
#------------------------

resource "aws_db_instance" "db_instance" {
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.39"
  multi_az               = false
  identifier             = "workshop23"
  username               = "zabbix"
  password               = random_string.for_rds_password.id
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = ["${aws_security_group.database_security_group.id}"]
  #availability_zone      = var.availability_zones[0]#data.aws_availability_zones.availability_zones.names[0]
  #db_name                = "db_zabbix"  
  skip_final_snapshot = true
  publicly_accessible = false
  deletion_protection = false
  tags = {
    name = "Workshop DB"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db_subnet_group"
  subnet_ids  = [aws_subnet.db_subnet_a.id, aws_subnet.db_subnet_b.id]
  description = "subnets for database instance"

  tags = {
    Name = "database_subnets"
  }
}

resource "random_string" "for_rds_password" {
  length  = 10
  lower   = true
  upper   = false
  numeric = true
  special = false
}