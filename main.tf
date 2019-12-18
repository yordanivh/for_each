provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  for_each = {
    server1_jordan = "ami-0520e698dd500b1d1"
    server2_jordan = "ami-0d5d9d301c853a04a"
  }

  ami = each.value
  tags = {
    name = each.key
  }
}

output "EC2_instance_information" {
  value = "${formatlist(
    "%s = %s", 
    (values(aws_instance.example)[*].tags.name),
    (values(aws_instance.example)[*].ami)
  )}"
}