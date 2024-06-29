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
