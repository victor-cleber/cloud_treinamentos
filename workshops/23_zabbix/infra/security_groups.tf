# Instance Security group (traffic ALB -> EC2, ssh -> EC2)
resource "aws_security_group" "alb_security_group" {
  name        = "alb_zabbix_security_group"
  description = "Allows inbound access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "app_security_group" {
  name        = "app_zabbix_security_group"
  description = "Allow HTTPS to web server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "app_zabbix_security_group"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "database_security_group" {
  name        = "database_zabbix_security-group"
  description = "Allow mariaDb access on port 3306"
  vpc_id      = aws_vpc.main.id


  ingress {
    description     = "MariaDb ingress"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_security_group.id, aws_security_group.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "database_zabbix_security_group"
  }

  lifecycle {
    create_before_destroy = true
  }

}