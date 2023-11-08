terraform {
  backend "s3" {
    bucket = "terraform-ec2-postgres"
    region = "us-east-1"
    key = "ec1-postgres-terraform.tf.state"
    # dynamodb_table = "terraform-statelock"
  }
}

resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_1.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "EC2"
  }

}