

resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  #vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  #iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name = "MonthlyBackupEC2"
    backup = "true"  # Enables backup selection 
    
  }
   volume_tags = {
      backup = "true"
  }
}

