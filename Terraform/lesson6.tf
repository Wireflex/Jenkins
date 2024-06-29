#==============================================#
  lifecycle {
    prevent_destroy = true
  }

  lifecycle {
    ignore_changes = ["ami", "user_data"]
  }

  lifecycle {
    create_before_destroy = true
  }

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.allow_http_https_ssh.id
}
#=============================================#

# TERRAFORM by Wireflex

provider "aws" {}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.web_server.id
}
resource "aws_security_group" "web_server" {
  name = "allow_http_https_ssh"
  description = "Allow HTTP, HTTPS and SSH inbound traffic"

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0a3041ff14fb6e2be"
  instance_type = "t2.micro"
  key_name = "wireflex-key-frankfurt"

  vpc_security_group_ids = [aws_security_group.web_server.id]

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Nikita",
    l_name = "Utyaganov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Wireflex"
  }
    lifecycle {
    create_before_destroy = true
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
