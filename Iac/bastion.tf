resource "aws_instance" "Task11-Bastion" {
  ami = "ami-0a49b025fffbbdac6"
  instance_type = "t2.micro"
  key_name = "51ame-newkey-frankfurt"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  security_groups = [aws_security_group.bastion-sg.id]
  tags = {
    Name = "Task11-Bastion"
  }
}