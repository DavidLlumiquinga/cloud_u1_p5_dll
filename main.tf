#configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

#Creamos el security group
resource "aws_security_group" "mi-sg" {
  name = "mi-security-group-terraform"
  description = "security group para instancia de terraform"
  vpc_id = "vpc-09b14f4b1df091d8b"
  #reglas de entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }  
  #reglas de entrada SSH
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }  

  #reglas de salida HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

#Declaracion de los recursos a aprovisionar AWS
resource "aws_instance" "mi_instancia_2" {
  ami="ami-0f79cf3a8ae221a95"
  instance_type = "t2.micro"
  key_name="mi-primera-llaves-dll"
  tags={
    Name = "MiInstanciaTerraform2"
  }
  vpc_security_group_ids =[aws_security_group.mi-sg.id]
}
