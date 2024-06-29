# TERRAFORM by Wireflex  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group

provider "aws" {
  region = "eu-central-1"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "my_webserver" {
  ami                         = "ami-04f1b917806393faa"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.my_webserver.id]
  user_data_replace_on_change = true
  user_data                   = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!"  >  /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Wireflex"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Wireflex"
  }
}
