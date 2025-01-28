resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.zabbix_server}.pem"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "srv_zabbix_01" {
  ami                         = "ami-0e1bed4f06a3b463d"
  subnet_id                   = aws_subnet.alb_subnet_a.id
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
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

# resource "aws_instance" "jump_host" {
#   ami                         = "ami-0e1bed4f06a3b463d"
#   subnet_id                   = aws_subnet.alb_subnet_a.id
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.ec2_server.key_name
#   security_groups             = [aws_security_group.app_security_group.id]
#   user_data                   = <<EOF
#         # #!/bin/bash
#         # echo "Copying the SSH Key to the server"
#         # echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClFU5XpYf/MTYakVv8T+oYRohKCjtXSTaFM07atOA7yJfRES1a2SbNSo5cATIhQQnGtuZICH9dc0XD0nCcoyX8EcB9Mr5k+HglpVbvXHWPsG537Rfz7gG7fc1g7XC0TijXfPnhA5j3tsV/bqKd0LwV56nVNjbWFIsnWWAMS9wAKIWAMgG/LUxr6jId33QarVyNDd+ukU5Iqk5u5+wPCiRofFtssn8XwZbtzQ41fafK1SNE8GBwbGGhUjSciUYXJycrtJoWbR3Q9dYMxRb1gpIWde0+jzHielbmuRBID1enQtKxrFemoKU4wJJEI3Ff0s6CJAzwvH4SxirfiL0jrMggn52YE5HA8d6cdKvHGASxikGr5MHsbYdy473MWzanSGT/VHyZ3hQBEMWV4iGt1CUlIW3iDHtoRhJY5JQTRORw7HZ8UgYeNIVVMds0kTwfuKMUz7VrxOkOFk15wL4ZeNKecaKBhkjd0ZAYsZIebmuz1SbylTVkoAzHXcfNPfoWshKGYponY97qBfHz+o+m7bO/i6z4fPZl0NtFX6g2ezGtcU3V8edckT8zZoVdgaLZo7X9RdezyVc2V0LJalDwRKNEVvlCLBcTxzH8lGQ9+hkbXr0qdKMW+lzclUU6WgPIdGaHaZcr/DPnGEVaIegEN4BVNXkBgbcAzHgOnfT36gCWcw== victor@L2752"
#         #  >> /home/ubuntu/.ssh/authorized_keys
#         sudo su
#         yes | apt update
#         yes | apt install apache2
#         echo "<h1>Server Details</h1><p><strong>Hostname: </strong> $(hostname)</p><p><strong>IP Address: </strong> $(hostname -I | cut -d " " -f1)</p>" > /var/www/html/index.html
#         systemctl restart apache2         
#       EOF
#   tags = {
#     Name = var.ec2_jump_host
#   }
# }

