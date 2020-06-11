
variable "zone_records" {
  type = map(object({
    comment = string,
    records = list(object({
      name   = string,
      type   = string,
      ttl    = number,
      values = list(string)
    }))
  }))
  description = "Map of Route53 Hosted Zones and their associated Route53 Records"
}
