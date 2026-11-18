output "ids_instancias" {
  description = "IDs de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].id
}

output "cantidad_instancias" {
  description = "Cantidad de las instancias creadas"
  value = length(aws_instance.mi_instancia_efs)
}


output "ip_publica_instancias" {
  description = "IP's publicas de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].public_ip
}

output "zonas_disponibles" {
  description = "Zonas disponibles de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].availability_zone
}