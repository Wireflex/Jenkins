provider "aws" {}

resource "aws_security_group" "allow_http_https_ssh" {
  name = "allow_http_https_ssh"
  description = "Allow HTTP, HTTPS and SSH inbound traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

  vpc_security_group_ids = [aws_security_group.allow_http_https_ssh.id]

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Nikita",
    l_name = "Utyaganov",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Wireflex"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
