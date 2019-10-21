# alias

[![Build Status](https://drone.techservices.illinois.edu/api/badges/techservicesillinois/terraform-aws-alias/status.svg)](https://drone.techservices.illinois.edu/techservicesillinois/terraform-aws-alias)

Provides a Route 53 alias whose target is an Cloudfront or S3.

This module provides a Route 53 alias whose target is an Cloudfront or S3. 

Example Usage
-----------------

### Alias to an ALB in a public Route 53 zone
```hcl
module "alias" {
  source   = "git@github.com:techservicesillinois/terraform-aws-alias//"

  hostname = "directory-editor-tf"
  domain   = "as-test.techservices.illinois.edu"
  cloudfront_domain = "d355upuvdmfom8.cloudfront.net"
}
```


Argument Reference
-----------------

The following arguments are supported:

* `domain` - (Required) Domain in which to create Route53 record

* `hostname` - (Required) Hostname for Route53 record

* `zone_id` - (Required) Hostname for Route53 record

* `cloudfront_domain` - (Required) DNS domain name for a CloudFront distribution


Attributes Reference
--------------------

The following attributes are exported:

* `fqdn` – The fully-qualified domain name of the Route 53 record created.
