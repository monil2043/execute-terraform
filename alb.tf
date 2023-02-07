resource "aws_lb" "webapp_alb" {
  name               = "springboot-load-balancer"
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-security-group-springboot.id]
  subnets = [aws_subnet.dev-public-1.id,aws_subnet.dev-public-2.id ]

  tags = {
    Name = "springboot-load-balancer"
  }
}

resource "aws_lb_target_group" "springboot-target-group" {
  name     = "springboot-target-group"
  port     = 8080
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = aws_vpc.dev.id

  lifecycle {
    create_before_destroy = true
  }

  health_check {
    interval = 10
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.webapp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.springboot-target-group.arn
  }
}