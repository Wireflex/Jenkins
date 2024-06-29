provider "aws" {}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-01e444924a2233b07"
  instance_type = "t2.micro"
}

# export AWS_ACCESS_KEY_ID=ключ
# export AWS_SECRET_ACCESS_KEY=ключ
# export AWS_DEFAULT_REGION=регион

# либо 1 раз залогиниться, AWS CONFIGURE
