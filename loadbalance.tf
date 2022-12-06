resource "aws_lb_target_group" "my_tg" {
  vpc_id = var.vpc_id
  name     = "my-lb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"

    health_check {
    protocol = "HTTP"
    port = "80"
    healthy_threshold = 3
    interval = 6

  
    }
}
resource "aws_lb_target_group" "my_tg1" {
  vpc_id = var.vpc_id
  name     = "my-lb-tg1"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"

    health_check {
    protocol = "HTTP"
    port = "80"
    healthy_threshold = 3
    interval = 6

  
    }
}
resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [ "subnet-0202045356b1c119b", "subnet-021eca06684b7129b" ]
  security_groups = [ "sg-06ca35c08399b1122" ]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

resource "aws_alb_target_group_attachment" "tgattachment" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = "i-0cb4f741a42bb9887"
}
resource "aws_alb_target_group_attachment" "tgattachment1" {
  target_group_arn = aws_lb_target_group.my_tg1.arn
  target_id        = "i-022fc95a4896361fc"
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}
resource "aws_lb_listener" "front_end1" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}
resource "aws_lb_listener_rule" "front_end" {
  listener_arn = aws_lb_listener.front_end.arn
 action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }

  condition {
    path_pattern {
      values = ["/admin/*"]
    }
  }
  depends_on = [
    aws_lb_target_group.my_tg
  ]
}
resource "aws_lb_listener_rule" "front_end1" {
  listener_arn = aws_lb_listener.front_end1.arn
 action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg1.arn
  }

  condition {
    path_pattern {
      values = ["/order/*"]
    }
  }
  depends_on = [
    aws_lb_target_group.my_tg
  ]
}
