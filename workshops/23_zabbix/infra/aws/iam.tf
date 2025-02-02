#--------------------------
# EC2 IAM INSTANCE PROFILE
#--------------------------
resource "aws_iam_role" "ec2_iam_role" {
  name        = "ec2-role"
  description = "The role for acessing resources EC2 using SSM"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach the user-managed-policy to the Role
resource "aws_iam_role_policy_attachment" "iam_attach_ssm" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Creates a instance profile to attach the role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_iam_role.name
}

resource "aws_iam_role_policy_attachment" "iam_attach_s3" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = aws_iam_policy.ec2_policy_to_s3.arn
}


resource "aws_iam_policy" "ec2_policy_to_s3" {
  name        = "AllowsEc2ToSeeS3"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowsEc2ToSeeS3",
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_attach_secrets_manager" {
  role       = aws_iam_role.ec2_iam_role.name
  policy_arn = aws_iam_policy.ec2_policy_to_secrets_manager.arn
}

resource "aws_iam_policy" "ec2_policy_to_secrets_manager" {
  name        = "AllowEC2ToSeeSecretsPolicy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowEC2ToSeeSecretsPolicy",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}