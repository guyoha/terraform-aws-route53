# terrafrom-aws-rout53

This module provide easier way to create Route53 zones and associated records

## Running

- Ensure you have set the `AWS_PROFILE` environment variable to a profile that  
  has the right permissions to create R53 zones and records

## Implementation
- look under example sub directory

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.56.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.56.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| zone\_records | Map of Route53 Hosted Zones and their associated Route53 Records | <pre>map(object({<br>    comment = string,<br>    records = list(object({<br>      name   = string,<br>      type   = string,<br>      ttl    = number,<br>      values = list(string)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_records | Output List of records per zone |
| dns\_zone | Output List of zones |

