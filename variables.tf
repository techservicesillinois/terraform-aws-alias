variable "domain" {
  description = "Domain in which to create Route53 record"
}

variable "hostname" {
  description = "Hostname for Route53 record"
}

# For cloudfront zone_id is Z2FDTNDATAQYW2
# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-aliastarget.html#cfn-route53-aliastarget-hostedzoneid

variable "zone_id" {
  description = "Hostname for Route53 record"
  default     = "Z2FDTNDATAQYW2"
}

variable "cloudfront_domain" {
  description = "(Required) DNS domain name for a CloudFront distribution"
}
