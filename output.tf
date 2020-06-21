
output "dns_zone" {
  description = "Output List of zones"
  value = {
    for zone in aws_route53_zone.this :
    "zone" => zone.name...
  }
}

output "dns_records" {
  description = "Output List of records per zone"
  value = {
    for zoneKey, zone in aws_route53_zone.this :
    zoneKey => {
      comment = zone.comment
      zone_id = zone.id
      records = [
        for k, record in aws_route53_record.this : {
          name    = record.name
          records = record.records
          zone_id = record.zone_id
          ttl     = record.ttl
          type    = record.type
        }
      ]
    }
  }
}

output "dns_alias_records" {
  description = "Output List of records per zone"
  value = {
    for zoneKey, zone in aws_route53_zone.this :
    zoneKey => {
      comment = zone.comment
      zone_id = zone.id
      records = [
        for k, record in aws_route53_record.alias_records : {
          name    = record.name
          records = record.records
          type    = record.type
          alias   = record.alias

        }
      ]
    }
  }
}