#Configuracion del proveedor
provider "aws" {
  region = var.region
}

#Creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security group para instancia EC2 con EFS"
  vpc_id      = "vpc-09b14f4b1df091d8b"

  # REGLAS DE ENTRADA

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NFS - EFS
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # REGLAS DE SALIDA

  # HTTP
  egress {
    description = "Allow all outbounf traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NFS - EFS
  egress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Creamos el security group
resource "aws_security_group" "mi-sg-efs" {
  name = "mi-security-group-terraform-efs"
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
resource "aws_instance" "mi_instancia_efs" {
  ami=var.ami_id
  instance_type = var.tipo_instancia
  key_name= var.nombre_llave
  security_groups = [ aws_security_group.mi-sg-efs.name ]
    count = var.cantidad_instancias
  tags={
    Name = "Mi instancia EFS -${count.index+1}"
  }
  vpc_security_group_ids =[aws_security_group.mi-sg-efs-instancias.id]
}

