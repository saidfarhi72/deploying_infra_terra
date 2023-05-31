
resource "aws_security_group" "elb_sg" {
  name = "terraform-example-elb"
  description = "Allow access on http and https from everywhere"
  vpc_id      = local.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
      security_groups = [aws_security_group.app_static_sg.id]

  }
   ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
      security_groups = [aws_security_group.app_static_sg.id]

  }
}
resource "aws_lb" "app" {
  name               = "front-end-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = aws_subnet.public_subnet.*.id

  enable_deletion_protection = false
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_target_group" "app" {
  name     = "front-end-lb-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.app.id
}