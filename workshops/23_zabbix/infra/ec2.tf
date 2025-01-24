resource "aws_instance" "zabbix_server"{
    ami = "ami-0e1bed4f06a3b463d"
    subnet_id = aws_subnet.alb_subnet_a.id
    instance_type = "t2.micro"
    associate_public_ip_address = true
    security_groups            = [aws_security_group.ec2.id]
    user_data = <<EOF
        #!/bin/bash
        echo "Copying the SSH Key to the server"
        echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClFU5XpYf/MTYakVv8T+oYRohKCjtXSTaFM07atOA7yJfRES1a2SbNSo5cATIhQQnGtuZICH9dc0XD0nCcoyX8EcB9Mr5k+HglpVbvXHWPsG537Rfz7gG7fc1g7XC0TijXfPnhA5j3tsV/bqKd0LwV56nVNjbWFIsnWWAMS9wAKIWAMgG/LUxr6jId33QarVyNDd+ukU5Iqk5u5+wPCiRofFtssn8XwZbtzQ41fafK1SNE8GBwbGGhUjSciUYXJycrtJoWbR3Q9dYMxRb1gpIWde0+jzHielbmuRBID1enQtKxrFemoKU4wJJEI3Ff0s6CJAzwvH4SxirfiL0jrMggn52YE5HA8d6cdKvHGASxikGr5MHsbYdy473MWzanSGT/VHyZ3hQBEMWV4iGt1CUlIW3iDHtoRhJY5JQTRORw7HZ8UgYeNIVVMds0kTwfuKMUz7VrxOkOFk15wL4ZeNKecaKBhkjd0ZAYsZIebmuz1SbylTVkoAzHXcfNPfoWshKGYponY97qBfHz+o+m7bO/i6z4fPZl0NtFX6g2ezGtcU3V8edckT8zZoVdgaLZo7X9RdezyVc2V0LJalDwRKNEVvlCLBcTxzH8lGQ9+hkbXr0qdKMW+lzclUU6WgPIdGaHaZcr/DPnGEVaIegEN4BVNXkBgbcAzHgOnfT36gCWcw== victor@L2752" >> /home/ubuntu/.ssh/authorized_keys
        EOF
    tags = {
        Name = "Zabbix_server"
    }


}