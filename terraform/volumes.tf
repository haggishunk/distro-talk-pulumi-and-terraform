resource "aws_ebs_volume" "web-data" {
  count = "${var.count}"
  availability_zone = "us-west-2c"
  size  = 10

  tags {
    Name = "Terraform Demo ${count.index}"
  }
}

resource "aws_volume_attachment" "web-data-attach" {
  count       = "${var.count}"
  device_name = "/dev/sdh"
  volume_id   = "${element(aws_ebs_volume.web-data.*.id, count.index)}"
  instance_id = "${element(aws_instance.web.*.id, count.index)}"
}
