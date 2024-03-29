resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "monil-demo-app-launchCOnfig"
  image_id      = "ami-0cca134ec43cf708f"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.SSMRoleForEC2SpringAppDeployment.name
  user_data = <<EOF
	
	#!/bin/bash
	sudo su
	yum update -y
	yum install java-1.8.0-openjdk -y
	KEY=`aws s3 ls save-application-jars --recursive | sort | tail -n 1 | awk '{print $4}'`
	aws s3 cp s3://save-application-jars/$KEY ./
	sudo java -jar *.jar
	EOF

  security_groups = [aws_security_group.web-security-group-springboot.id]




  lifecycle {
    create_before_destroy = true
  }
}
