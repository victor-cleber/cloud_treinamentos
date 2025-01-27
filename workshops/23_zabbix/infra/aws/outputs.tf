output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "zabbix_ip" {
  value = aws_instance.srv_zabbix.public_ip
}

# output "graphana_ip" {
#   value = aws_instance.srv_graphana.public_ip
# }

output "rds_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

output "rds_password" {
  value     = aws_db_instance.db_instance.password
  sensitive = true
}

output "user_name"{
    value = var.user_name
    sensitive = false
}