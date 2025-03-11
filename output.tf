output "efs_dns_name" {
  value = aws_efs_file_system.aws_efs_file_system.dns_name
}

output "efs_id" {
  value = aws_efs_file_system.aws_efs_file_system.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.aws_efs_access_point.id
}

output "efs_id_app2" {
  value = aws_efs_file_system.aws_efs_file_system_app2.id
}

output "efs_access_point_app2_id" {
  value = aws_efs_access_point.aws_efs_access_point_app2.id
}
