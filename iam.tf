resource "aws_iam_role" "SSMRoleForEC2SpringAppDeployment" {
  name = "SSMRoleForEC2SpringAppDeployment"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}


resource "aws_iam_instance_profile" "SSMRoleForEC2SpringAppDeployment"{
name = "SSMRoleForEC2SpringAppDeployment"
role= aws_iam_role.SSMRoleForEC2SpringAppDeployment.name

}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
for_each = toset([
"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
"arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
])
  role       = aws_iam_role.SSMRoleForEC2SpringAppDeployment.name
  policy_arn = each.value
}