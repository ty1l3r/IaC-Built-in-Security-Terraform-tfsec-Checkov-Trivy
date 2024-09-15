# Sortie du nom de la paire de clés SSH
output "key_name" {
  description = "Nom de la paire de clés SSH"
  value       = aws_key_pair.myec2key.key_name
}

# Sortie de l'ID du groupe de sécurité privé pour WordPress
output "private_wp_sg_id" {
  value = aws_security_group.sg_private_wp.id
}
