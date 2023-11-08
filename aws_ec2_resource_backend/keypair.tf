resource "aws_key_pair" "key_1" {
  key_name   = "tempkey"
  public_key = file("${path.module}/id_rsa.pub")
}