
# Create AWS ALB

resource "aws_lb" "alb" {
    name                = "Task11-ALB"
    subnets             = module.vpc.public_subnets
    security_groups     = [aws_security_group.alb-sg.id]
    internal            = false

    enable_deletion_protection       = false
    enable_cross_zone_load_balancing = true
    load_balancer_type               = "application"

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name            = "Task11-ALB"
    }
}

# Create AWS LB target group

resource "aws_lb_target_group" "alb_target_group" {
    name                 = "Task11-alb-tg"
    port                 = "30080"
    protocol             = "HTTP"
    vpc_id               = module.vpc.vpc_id
    target_type          = "instance"

    tags = {
        Name             = "alb_target_group"
    }

    health_check {
        interval            = "60"
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = "5"
        unhealthy_threshold = "10"
        timeout             = "10"
        protocol            = "HTTP"
        matcher             = "200-299"
    }
    depends_on = [aws_lb.alb]
}

# Create AWS LB listeners
resource "aws_lb_listener" "frontend_http" {

    load_balancer_arn   = "${aws_lb.alb.arn}"
    port                = "80"
    protocol            = "HTTP"

    default_action {
        target_group_arn    = "${aws_lb_target_group.alb_target_group.arn}"
        type                = "forward"
    }

    depends_on = [aws_lb.alb,aws_lb_target_group.alb_target_group]
}

# resource "aws_lb_listener" "frontend_https" {

#     load_balancer_arn   = "${aws_lb.alb.arn}"
#     port                = 443
#     protocol            = "HTTPS"
#     certificate_arn     = "${var.certificate_arn}"
#     ssl_policy          = "ELBSecurityPolicy-2016-08"
#     default_action {
#         target_group_arn    = "${aws_lb_target_group.alb_target_group.arn}"
#         type                = "forward"
#     }

#     depends_on = ["aws_lb.alb","aws_lb_target_group.alb_target_group"]
# }
