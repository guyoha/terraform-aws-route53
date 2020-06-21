/**
 * # terrafrom-aws-route53
 *
 * This module provide easier way to create Route53 zones and associated records
 *
 * ## Running
 *
 * - Ensure you have set the `AWS_PROFILE` environment variable to a profile that
 *   has the right permissions to create R53 zones and records
 *
 * ## Implementation
 * - look under example sub directory
 */

# Restructure the input so terrafrom will know how to create the records
locals {
  records = flatten([
    for zoneName, zone in var.zone_records : [
      for record in lookup(zone, "records") : {
        zone   = zoneName
        name   = record.name
        values = record.values
        type   = record.type
        ttl    = record.ttl
      }
    ]
  ])
  alias_records = flatten([
    for zoneName, zone in var.zone_alias_records : [
      for record in lookup(zone, "records") : {
        zone                   = zoneName
        name                   = record.name
        alias                  = record.alias
        type                   = record.type
        alias_elb_hosted_zone  = record.alias_elb_hosted_zone
        evaluate_target_health = record.evaluate_target_health
      }
    ]
  ])
  enable_alias_records = var.enable_alias_records
}

locals {
  region = "us-east-1"
}

provider "aws" {
  version = "~> 2.56.0"
  region  = local.region
}

# Create Zones
resource "aws_route53_zone" "this" {
  for_each = var.zone_records

  name    = each.key
  comment = each.value.comment
}

# Create records
resource "aws_route53_record" "this" {
  for_each = {
    for r in local.records : "${r.zone}.${r.type}.${r.name}.${r.ttl}.${join(",", r.values)} " => r
  }

  name    = each.value.name
  zone_id = aws_route53_zone.this[each.value.zone].zone_id
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.values
}

resource "aws_route53_record" "alias_records" {
  for_each = {
    for r in local.alias_records : "${r.zone}.${r.type}.${r.name}.${r.alias}.${r.alias_elb_hosted_zone}.${r.evaluate_target_health}} " => r
    if local.enable_alias_records
  }

  name    = each.value.name
  zone_id = aws_route53_zone.this[each.value.zone].zone_id
  type    = each.value.type
  alias {
    evaluate_target_health = each.value.evaluate_target_health
    name                   = each.value.alias
    zone_id                = each.value.alias_elb_hosted_zone
  }
}






