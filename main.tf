resource "aws_security_group" "efs-sg" {
  name   = "efs-app-${var.environment}-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "allow ALL from Lambda"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = concat(data.terraform_remote_state.vpc.outputs.private_subnets_cidr, data.terraform_remote_state.vpc.outputs.db_subnets_cidr)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "aws_efs_file_system" {
  creation_token = "${var.environment}-efs-app"
  encrypted      = true
  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
  tags = {
    Name = "${var.environment}-efs-app"
  }
}

resource "aws_efs_mount_target" "aws_efs_mount_target" {
  count           = length(data.terraform_remote_state.vpc.outputs.db_subnets)
  file_system_id  = aws_efs_file_system.aws_efs_file_system.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.db_subnets[count.index]
  security_groups = [aws_security_group.efs-sg.id]
}

resource "aws_efs_access_point" "aws_efs_access_point" {
  file_system_id = aws_efs_file_system.aws_efs_file_system.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/videos"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }
}

########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
resource "aws_efs_file_system" "aws_efs_file_system_sonarqube" {
  count          = var.environment == "dev" ? 1 : 0
  creation_token = "${var.environment}-efs-sonarqube"
  encrypted      = true
  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
  tags = {
    Name = "${var.environment}-efs-sonarqube"
  }
}

resource "aws_efs_mount_target" "aws_efs_mount_target_sonarqube" {
  count           = var.environment == "dev" ? length(data.terraform_remote_state.vpc.outputs.db_subnets) : 0
  file_system_id  = aws_efs_file_system.aws_efs_file_system_sonarqube[0].id
  subnet_id       = data.terraform_remote_state.vpc.outputs.db_subnets[count.index]
  security_groups = [aws_security_group.efs-sg.id]
}

resource "aws_efs_access_point" "aws_efs_access_point_sonarqube_data" {
  count          = var.environment == "dev" ? 1 : 0
  file_system_id = aws_efs_file_system.aws_efs_file_system_sonarqube[0].id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/sonarqube-data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }
}

resource "aws_efs_access_point" "aws_efs_access_point_sonarqube_logs" {
  count          = var.environment == "dev" ? 1 : 0
  file_system_id = aws_efs_file_system.aws_efs_file_system_sonarqube[0].id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/sonarqube-logs"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }
}

resource "aws_efs_access_point" "aws_efs_access_point_sonarqube_extensions" {
  count          = var.environment == "dev" ? 1 : 0
  file_system_id = aws_efs_file_system.aws_efs_file_system_sonarqube[0].id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/sonarqube-extensions"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }
}

########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
resource "aws_efs_file_system" "aws_efs_file_system_pgadmin" {
  creation_token = "${var.environment}-efs-pgadmin"
  encrypted      = true
  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
  tags = {
    Name = "${var.environment}-efs-pgadmin"
  }
}

resource "aws_efs_mount_target" "aws_efs_mount_target_pgadmin" {
  count           = length(data.terraform_remote_state.vpc.outputs.db_subnets)
  file_system_id  = aws_efs_file_system.aws_efs_file_system_pgadmin.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.db_subnets[count.index]
  security_groups = [aws_security_group.efs-sg.id]
}

resource "aws_efs_access_point" "aws_efs_access_point_pgadmin" {
  file_system_id = aws_efs_file_system.aws_efs_file_system_pgadmin.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/pgadmin"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }
}
