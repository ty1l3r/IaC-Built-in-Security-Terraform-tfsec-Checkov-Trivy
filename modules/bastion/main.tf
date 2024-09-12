resource "aws_instance" "bastion_a" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_a_id  # ID du sous-réseau pour l'instance Bastion A
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]
  key_name               = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "fabien-bastion-a"
  }
}

resource "aws_instance" "bastion_b" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_b_id # ID du sous-réseau pour l'instance Bastion B
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]
  key_name               = var.key_name
  associate_public_ip_address = true
  tags = {
    Name = "fabien-bastion-b"
  }
}
