module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name = "application-ec2"

  ami           = "ami-xxxxxxxx"
  instance_type = "t3.micro"

  subnet_id = "subnet-xxxxxxxx"

  vpc_security_group_ids = ["sg-xxxxxxxx"]

  iam_instance_profile = module.ec2_role.iam_instance_profile_name

  tags = {
    Environment = "dev"
  }
}
