# Find specified load balancer in order to retrieve dns_name and zone_id
# attributes of target ALB.

# Find Route 53 zone specified by domain variable in order to retrieve
# zone_id attribute of zone in which alias record is being managed.

data "aws_route53_zone" "selected" {
  name = var.domain
}
