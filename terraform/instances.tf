resource "aws_instance" "web" {
  count                  = "${var.count}"
  ami                    = "${data.aws_ami.nat-ami.id}"
  availability_zone      = "us-west-2c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web-in.id}"]

  tags {
    Name = "Terraform Demo ${count.index}"
  }
}
