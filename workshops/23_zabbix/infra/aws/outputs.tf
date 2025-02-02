output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

output "zabbix_server_ip" {
  value = aws_instance.srv_zabbix.public_ip
}

output "grafana_server_ip" {
  value = aws_instance.srv_grafana.public_ip
}

output "glpi_server_ip" {
  value = aws_instance.srv_glpi.public_ip
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