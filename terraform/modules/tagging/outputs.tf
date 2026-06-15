output "required_tags" {
  description = "Required TITAN governance tags."
  value       = local.required_tags
}

output "tags" {
  description = "Merged required and additional tags."
  value       = local.tags
}