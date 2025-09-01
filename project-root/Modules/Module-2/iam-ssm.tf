

resource "aws_iam_role" "ssm_role" {
  #name = "ec2-ssm-role"
  name = var.role_name     //name of the role from variables.tf file

  assume_role_policy = jsonencode({        // This block creates an IAM role named ec2-ssm-role
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"  //This policy gives EC2 instances permissions to interact with AWS Systems Manager like sending logd, running comman
}

resource "aws_iam_instance_profile" "ssm_profile" {   // creates an instance profile named ec2-ssm-profile
  name = var.instance_profile_name   //name of the instance profile 
  role = aws_iam_role.ssm_role.name   //associated IAM role
}

