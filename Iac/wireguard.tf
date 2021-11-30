# Creating instance
resource "aws_instance" "Task11-Wireguard" {
  ami = "ami-0a49b025fffbbdac6"
  instance_type = "t2.micro"
  key_name = "51ame-newkey-frankfurt"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  security_groups = [aws_security_group.wireguard-sg.id]
  tags = {
    Name = "Task11-Wireguard"
  }
}
 # Creating Elastic IP for Wireguard
#  resource "aws_eip" "WG-IP" {
#     instance = aws_instance.Task11-Wireguard-Jenkins.id
#     vpc   = true
#     tags = {
#     Name = "Wireguard-EIP"
#   }
#  }  