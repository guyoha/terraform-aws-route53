
output "dns_entries" {
  value = module.dns_records.dns_zone
}

output "dns_records" {
  value = module.dns_records.dns_records
}

output "dns_alias_records" {
  value = module.dns_records.dns_alias_records
}

