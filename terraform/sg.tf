resource "aws_security_group" "web-in" {
  name        = "web-in"
  description = "Allow http"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
