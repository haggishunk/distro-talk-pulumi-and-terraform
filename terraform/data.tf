data "aws_ami" "nat-ami" {
  most_recent      = true
  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-hvm-2018*"]
  }
}

output "nat-ami" {
  value = "${data.aws_ami.nat-ami.description}"
}
