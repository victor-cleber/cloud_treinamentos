
resource "aws_key_pair" "ec2" {
  key_name   = "${var.zabbix_server}_key_pair"
  public_key = file(var.ssh_pubkey_file)
}


resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.zabbix_server}.pem"
  public_key = tls_private_key.example.public_key_openssh
}


resource "aws_instance" "srv_zabbix" {
  ami                         = "ami-0e1bed4f06a3b463d"
  subnet_id                   = aws_subnet.alb_subnet_a.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  #key_name                    = aws_key_pair.ec2.key_name

  key_name                    = aws_key_pair.generated_key.key_name

  security_groups             = [aws_security_group.alb_security_group.id]
  # user_data                   = <<EOF
  #        sudo su
  #       yes | apt update
  #       yes | apt install apache2
  #       echo "<h1>Server Details</h1><p><strong>Hostname: </strong> $(hostname)</p><p><strong>IP Address: </strong> $(hostname -I | cut -d " " -f1)</p>" > /var/www/html/index.html
  #       systemctl restart apache2         
  #     EOF
  root_block_device {
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = var.zabbix_server
  }
  depends_on = [aws_security_group.alb_security_group, aws_key_pair.generated_key]
}

resource "aws_instance" "srv_grafana" {
  ami                         = "ami-0e1bed4f06a3b463d"
  subnet_id                   = aws_subnet.alb_subnet_a.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.alb_security_group.id]
  user_data                   = <<EOF
        sudo su
        yes | apt update
        yes | apt install apache2
        echo "<h1>Server Details</h1><p><strong>Hostname: </strong> $(hostname)</p><p><strong>IP Address: </strong> $(hostname -I | cut -d " " -f1)</p>" > /var/www/html/index.html
        systemctl restart apache2         
      EOF
  root_block_device {
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = var.grafana_server
  }
  depends_on = [aws_security_group.alb_security_group, aws_key_pair.generated_key]
}

resource "aws_instance" "srv_glpi" {
  ami                         = "ami-0e1bed4f06a3b463d"
  subnet_id                   = aws_subnet.alb_subnet_a.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.alb_security_group.id]


  root_block_device {
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = var.glpi_server
  }
  depends_on = [aws_security_group.alb_security_group, aws_key_pair.generated_key]
}
