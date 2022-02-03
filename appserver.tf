#-------------------------
# Key pair
#-------------------------
resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file("./src/tmp-dev-key.pub")

  tags = {
    Name    = "${var.project}-${var.environment}-keypair"
    Project = var.project
    Env     = var.environment
  }
}

#-------------------------
# EC2 Instance
#-------------------------
resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.app.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.scenery_tagging_public_subnet_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.scenery-tagging-app-sg.id,
    aws_security_group.scenery-tagging-opmg-sg.id
  ]
  key_name = aws_key_pair.keypair.key_name


  tags = {
    Name    = "${var.project}-${var.environment}-app_server"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }
}