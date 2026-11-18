#region donde se desplegaran los recursos
variable "region" {
  description = "The AWS region"
  type = string
  default = "us-east-1"
}

variable "ami_id" {
 description = "id de la ami"
 type = string
 default = "ami-0f79cf3a8ae221a95"
}

variable "tipo_instancia" {
    description = "Tipo de instancia"
    type = string
    default = "t2.micro"
}

variable "nombre_llave" {
  description = "Nombre del par de llaves"
  type = string
  default = "mi-primera-llaves-dll"
}

variable "cantidad_instancias" {
  description = "cantidad de instancias"
  type = number
  default = 1
}