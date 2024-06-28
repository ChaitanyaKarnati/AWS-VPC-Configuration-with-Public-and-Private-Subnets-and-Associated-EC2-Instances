
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region.
}

variable "cidr" {
  default = "10.0.0.0/16"
}


resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT_public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.RT_public.id
}

resource "aws_security_group" "publ" {
  name   = "publ"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "publ"
  }
}


resource "aws_subnet" "private" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}


resource "aws_route_table" "RT_private" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.RT_private.id
}

resource "aws_eip" "example" {
 
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

}

resource "aws_security_group" "priv" {
  name   = "priv"
  vpc_id = aws_vpc.myvpc.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "priv"
  }
}




resource "aws_instance" "public" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.publ.id]
  subnet_id = aws_subnet.public.id

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host = self.public_ip
  }
}

resource "aws_instance" "private" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.priv.id]
  subnet_id = aws_subnet.private.id
}
