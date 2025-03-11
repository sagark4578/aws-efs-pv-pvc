output "efs_dns_name" {
  value = aws_efs_file_system.aws_efs_file_system.dns_name
}

output "efs_id" {
  value = aws_efs_file_system.aws_efs_file_system.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.aws_efs_access_point.id
}

output "efs_id_pgadmin" {
  value = aws_efs_file_system.aws_efs_file_system_pgadmin.id
}

output "efs_access_point_pgadmin_id" {
  value = aws_efs_access_point.aws_efs_access_point_pgadmin.id
}

output "efs_sonarqube_id" {
  value = var.environment == "dev" ? aws_efs_file_system.aws_efs_file_system_sonarqube[0].id : null
}

output "efs_access_point_sonarqube_data_id" {
  value = var.environment == "dev" ? aws_efs_access_point.aws_efs_access_point_sonarqube_data[0].id : null
}

output "efs_access_point_sonarqube_logs_id" {
  value = var.environment == "dev" ? aws_efs_access_point.aws_efs_access_point_sonarqube_logs[0].id : null
}

output "efs_access_point_sonarqube_extensions_id" {
  value = var.environment == "dev" ? aws_efs_access_point.aws_efs_access_point_sonarqube_extensions[0].id : null
}
