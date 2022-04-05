output "web_1_id" {
value = aws_instance.web_1.id
}

output "web_1_privat_ip" {
value = aws_instance.web_1.private_ip
}

output "web_1_public_ip" {
value = aws_instance.web_1.public_ip
description = "This is public ip of instance web_1"
}
