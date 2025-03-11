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
    path = "/path1"
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
#creation of app

resource "aws_efs_file_system" "aws_efs_file_system_app2" {
  creation_token = "${var.environment}-efs-app2"
  encrypted      = true
  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
  tags = {
    Name = "${var.environment}-efs-app2"
  }
}

#mount app
resource "aws_efs_mount_target" "aws_efs_mount_target_app2" {
  count           = length(data.terraform_remote_state.vpc.outputs.db_subnets)
  file_system_id  = aws_efs_file_system.aws_efs_file_system_app2.id
  subnet_id       = data.terraform_remote_state.vpc.outputs.db_subnets[count.index]
  security_groups = [aws_security_group.efs-sg.id]
}

#given permisson to app with the path if avaible 
resource "aws_efs_access_point" "aws_efs_access_point_app2" {
  file_system_id = aws_efs_file_system.aws_efs_file_system_app2.id
  posix_user {
    gid = 1000
    uid = 1000
  }
  root_directory {
    path = "/app2"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
  }
}
