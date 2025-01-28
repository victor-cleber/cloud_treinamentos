output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

output "server_ip" {
  value = aws_instance.srv_zabbix_01.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

output "rds_username" {
  value     = aws_db_instance.db_instance.username
  sensitive = true
}

output "rds_password" {
  value     = aws_db_instance.db_instance.password
  sensitive = true
}