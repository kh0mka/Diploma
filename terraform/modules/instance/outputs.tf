output "instance_ids" {
  value = aws_instance.instance_of_web_server.*.id
}

output "instance_public_ip" {
  value = aws_eip.web-srv-eip.*.public_ip
}
