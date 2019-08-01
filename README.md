# alias-lb

Provides a Route 53 alias whose target is an Amazon application load balancer (ALB).

This module provides a Route 53 alias whose target is an application load balancer. This module exists for cases in which a Route 53 alias needs to be managed using a _separate life cycle_ from the load balancer itself or an ECS service.

### Lifecycle options for Route 53 aliases

#### In the `lb` module

When creating an application load balancer, Amazon creates a hostname like `public-8675309.us-east-2.elb.amazonaws.com`. While this uniquely identifies the ALB, the assigned name is neither invariant nor user-friendly.

The `lb` module therefore creates a Route 53 alias record like `public.some-fully-qualified-domain-name` that can be used by downstream consumers (like users of the `ecs-service` module) as a symbolic reference to the load balancer, and which can be easily reprovisioned if the load balancer needs to be spun down and relaunched.

Use the source `git@github.com:cites-illinois/as-aws-modules//lb` when creating a load balancer with one or more Route 53 aliases. For more information, see the [manual page for the **lb** module](https://github.com/cites-illinois/as-aws-modules/blob/master/lb/README.md).


#### In the `ecs-service` module

When using the `ecs-service` module to create a containerized ECS service with an application load balancer (ALB), it is customary to create a Route 53 alias for the container that points to the ALB.

This alias serves as the public identity for the deployed service, and is also used in the `host_header` used by the ALB to route requests to the proper ECS container.

Since this type of alias is tied to the ECS container, the alias's lifecycle is concurrent with the container's lifecycle.

Use the source `git@github.com:cites-illinois/as-aws-modules//ecs-service` when creating an ECS containerized service  with one or more Route 53 aliases. For more information, see the [manual page for the **ecs-service** module](https://github.com/cites-illinois/as-aws-modules/blob/master/ecs-service/README.md).

#### Separate from the `lb` and `ecs-service` module

Some cases exist where an alias is shared among several containerized microservices. In these cases, it is inappropriate to tie a Route 53 alias to any one of those containers, since each container can be shut down and restarted independently of the others. And yet such aliases should be manageable by the product developer or product owner of the respective service, rather than by the central infrastructure manager.

It is for this purpose that the `alias-lb` module exists. By this means, the product developer or owner can manage the lifecycle of the alias, and maintain it independently from the lifecycle of any containers making up the product.

Example Usage
-----------------

### Alias to an ALB in a public Route 53 zone
```hcl
module "alias" {
  source   = "git@github.com:cites-illinois/as-aws-modules//alias-lb"

  hostname = "my-public-alias"
  domain   = "some-fully-qualified-domain-name"
  lb_name  = "public"
}
```

### Alias to an ALB in a private Route 53 zone
```hcl
module "alias" {
  source   = "git@github.com:cites-illinois/as-aws-modules//alias-lb"

  hostname = "my-private-alias"
  domain   = "local"
  lb_name  = "private"
}
```

Note that for a private load balancer, it is necessary only to specify the same arguments as for a public load balancer. Though more than one private Route 53 zone with the same name can exist, one for each Virtual Private Cloud (VPC) in the account, a load balancer is tied to exactly one VPC, and load balancer names are unique across an AWS account.

As a result, the user of `alias-lb` does not need to specify the VPC when creating an alias in a private Route 53 zone. The `lb_name` argument is sufficient to identify the ALB, which in turn identifies the vpc_id needed to address the proper private Route 53 hosted zone.

Argument Reference
-----------------

The following arguments are supported:

* `hostname` - (Required) The name of the host to be created in the specified Route
53 zone.

* `domain` - (Required) The name of the Route 53 zone in which the alias record
is to be created.

* `lb_name` - (Required) The name of the Application Load Balancer that will serve as the target to the Route 53 alias record.


Attributes Reference
--------------------

The following attributes are exported:

* `fqdn` – The fully-qualified domain name of the Route 53 record created.
