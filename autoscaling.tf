resource "aws_autoscaling_group" "webapp_asg" {
  vpc_zone_identifier = [aws_subnet.dev-public-1.id,aws_subnet.dev-public-2.id]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  target_group_arns = [aws_lb_target_group.springboot-target-group.arn]
  health_check_grace_period = 120

  tag {
    key                 = "springboot-demo-app"
    value               = "springboot-demo-worker"
    propagate_at_launch = true
  }

  instance_refresh{
    strategy = "Rolling"

  }

  launch_configuration = aws_launch_configuration.as_conf.name
}
