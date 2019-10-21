# Manage Route 53 alias record for public zone.

resource "aws_route53_record" "default" {
  # Zone and name of Route53 record being managed.
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.hostname
  type    = "A"

  alias {
    # Target of Route53 alias.
    name                   = var.cloudfront_domain
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}
