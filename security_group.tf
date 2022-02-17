#-------------------------
# Security group
#-------------------------

# web security
resource "aws_security_group" "scenery-tagging-web-sg" {
  name        = "${var.project}-${var.environment}-web-sg"
  description = "web front role security group"
  vpc_id      = aws_vpc.vpc-scenery-tagging.id

  tags = {
    Name    = "${var.project}-${var.environment}-web-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "scenery-tagging-web-sgr_in_http" {
  security_group_id = aws_security_group.scenery-tagging-web-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "scenery-tagging-web-sgr_in_https" {
  security_group_id = aws_security_group.scenery-tagging-web-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "scenery-tagging-web-sgr_out_http" {
  security_group_id = aws_security_group.scenery-tagging-opmg-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "scenery-tagging-web-sgr_out_https" {
  security_group_id = aws_security_group.scenery-tagging-opmg-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "scenery-tagging-app-sgr_out_tcp3000" {
  security_group_id        = aws_security_group.scenery-tagging-web-sg.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3000
  to_port                  = 3000
  # source_security_group_id = aws_security_group.scenery-tagging-app-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "scenery-tagging-app-sgr_out_tcp5000" {
  security_group_id        = aws_security_group.scenery-tagging-web-sg.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 5000
  to_port                  = 5000
  # source_security_group_id = aws_security_group.scenery-tagging-app-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# app security
resource "aws_security_group" "scenery-tagging-app-sg" {
  name        = "${var.project}-${var.environment}-app-sg"
  description = "app server role security group"
  vpc_id      = aws_vpc.vpc-scenery-tagging.id

  tags = {
    Name    = "${var.project}-${var.environment}-app-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "scenery-tagging-web-sgr_in_tcp3000" {
  security_group_id = aws_security_group.scenery-tagging-web-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3000
  to_port           = 3000
  # source_security_group_id = aws_security_group.scenery-tagging-app-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "scenery-tagging-web-sgr_in_tcp5000" {
  security_group_id = aws_security_group.scenery-tagging-web-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 5000
  to_port           = 5000
  # source_security_group_id = aws_security_group.scenery-tagging-app-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# operation and management security
resource "aws_security_group" "scenery-tagging-opmg-sg" {
  name        = "${var.project}-${var.environment}-opmg-sg"
  description = "operation and management role security group"
  vpc_id      = aws_vpc.vpc-scenery-tagging.id

  tags = {
    Name    = "${var.project}-${var.environment}-opmg-sg"
    Project = var.project
    Env     = var.environment
  }
}

resource "aws_security_group_rule" "scenery-tagging-opmg-sgr_in_ssh" {
  security_group_id = aws_security_group.scenery-tagging-opmg-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["133.32.176.165/32"]
}
