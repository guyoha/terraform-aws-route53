
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

variable "zone_alias_records" {
  type = map(object({
    comment = string,
    records = list(object({
      name                   = string,
      type                   = string,
      alias                  = string,
      alias_elb_hosted_zone  = string
      evaluate_target_health = bool
    }))
  }))
  description = "Map of Route53 Hosted Zones and their associated Alias Route53 Records (make sure to add enable_alias_records=true)"
}

variable "enable_alias_records" {
  description = "Enable/Disable the creation of an alias record"
  type        = bool
  default     = false
}
