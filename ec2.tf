module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name = "ec2-with-role"

  ami           = "ami-xxxxxxxx"
  instance_type = "t3.micro"

  iam_instance_profile = module.ec2_role.iam_instance_profile_name

  subnet_id = "subnet-xxxxxxxx"

  vpc_security_group_ids = ["sg-xxxxxxxx"]

  tags = {
    Environment = "dev"
  }
}
