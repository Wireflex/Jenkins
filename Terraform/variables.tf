provider "aws" {
  region = var.region
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.web_server.id
  //tags     = var.common_tags
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server IP" })

  /*
  tags = {
    Name    = "Server IP"
    Owner   = "Wireflex"
  }
*/

}

resource "aws_instance" "web_server" {
  ami           = "ami-0a3041ff14fb6e2be"
  instance_type = var.instance_type
  key_name      = "wireflex-key-frankfurt"
  vpc_security_group_ids = [aws_security_group.web_server.id]

  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server Build by Terraform" })
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web_server" {
  name   = "My Security Group"
  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server SecurityGroup" })
}
