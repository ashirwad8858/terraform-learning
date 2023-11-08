# resource "aws_instance" "web" {
#   ami = "ami-122334"
#   instance_type = "t2.micro"
# }


module "mywebserver" {
  source = "./module/webserver"
  image_id = var.image_id
  instance_type = "t2.small"
  key = file("${path.module}/id_rsa.pub")
  key_name = "${var.key_name}"
}

output "webserverpulicIP"  {
  value =   module.mywebserver.webserverpulicIP
}