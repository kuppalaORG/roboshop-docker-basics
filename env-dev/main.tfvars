env = "dev"
bastion_nodes = ["172.31.85.32/32"]
zone_id = "Z0217682200043ETYLGYJ"


vpc = {
  cidr              = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  web_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  app_subnets       = ["10.0.5.0/24", "10.0.6.0/24"]
  db_subnets        = ["10.0.7.0/24", "10.0.8.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  default_vpc_id    = "vpc-09677d72a79071da2"
  default_vpc_rt  = "rtb-072120ceff5e4bb16"
  default_vpc_cidr   = "172.31.0.0/16"
}

apps = {
    frontend = {
      subnet_reference      = "web"
      instance_type         = "t2.micro"
      allow_port            = 80
      allow_sg_cidr         = ["10.0.1.0/24", "10.0.2.0/24"] # IP ranges allowed in SG
      allow_lb_sg_cidr      = ["0.0.0.0/0"]
      capacity              = {
        min = 1
        max = 1
        desired = 1
      }
      lb_rule_priority = 1
      lb_ref           = "public"
    }

    catalogue = {
      subnet_reference      = "app"
      instance_type         = "t2.micro"
      allow_port            = 8080
      allow_sg_cidr         = ["10.0.5.0/24", "10.0.6.0/24"]
      allow_lb_sg_cidr    =  ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]

      capacity              = {
        min = 1
        max = 1
        desired = 1
      }
      lb_ref           = "private"
      lb_rule_priority = 1
  }
    cart = {
      subnet_reference      = "app"
      instance_type         = "t2.micro"
      allow_port            = 8080
      allow_sg_cidr         = ["10.0.5.0/24", "10.0.6.0/24"]
      allow_lb_sg_cidr    =  ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]

      capacity              = {
        min = 1
        max = 1
        desired = 1
      }

      lb_rule_priority = 2
      lb_ref           = "private"
  }
    user = {
      subnet_reference      = "app"
      instance_type         = "t2.micro"
      allow_port            = 8080
      allow_sg_cidr         = ["10.0.5.0/24", "10.0.6.0/24"]
      allow_lb_sg_cidr    =  ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]

      capacity              = {
        min = 1
        max = 1
        desired = 1
      }

      lb_rule_priority = 3
      lb_ref           = "private"
  }
    shipping = {
      subnet_reference      = "app"
      instance_type         = "t2.micro"
      allow_port            = 8080
      allow_sg_cidr         = ["10.0.5.0/24", "10.0.6.0/24"]
      allow_lb_sg_cidr    =  ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]
      capacity              = {
        min = 1
        max = 1
        desired = 1
      }
      lb_rule_priority = 4
      lb_ref           = "private"
  }
    payment = {
      subnet_reference      = "app"
      instance_type         = "t2.micro"
      allow_port            = 8080
      allow_sg_cidr         = ["10.0.5.0/24", "10.0.6.0/24"]
      allow_lb_sg_cidr    =  ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]
      capacity              = {
        min = 1
        max = 1
        desired = 1
      }
      lb_rule_priority = 5
      lb_ref           = "private"
  }
    dispatch = {
      subnet_reference      = "app"
      instance_type         = "t2.micro"
      allow_port            = 8080
      allow_sg_cidr         = ["10.0.5.0/24", "10.0.6.0/24"]
      allow_lb_sg_cidr    =  ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]
      capacity              = {
        min = 1
        max = 1
        desired = 1
      }
      lb_rule_priority = 6
      lb_ref           = "private"
  }
  }

db = {
  mongod = {
    subnet_reference    = "db"
    instance_type = "t2.micro"
    allow_port    = 27017
    allow_sg_cidr = ["10.0.5.0/24", "10.0.6.0/24"]
  }
  mysql = {
    subnet_reference    = "db"
    instance_type = "t2.micro"
    allow_port    = 3306
    allow_sg_cidr = ["10.0.5.0/24", "10.0.6.0/24"]
  }
  rabbitmq = {
    subnet_reference   = "db"
    instance_type = "t2.micro"
    allow_port    = 5672
    allow_sg_cidr = ["10.0.5.0/24", "10.0.6.0/24"]
  }
  redis = {
    subnet_reference    = "db"
    instance_type = "t2.micro"
    allow_port    = 6379
    allow_sg_cidr = ["10.0.5.0/24", "10.0.6.0/24"]
  }
}

load_balancers = {
  private = {
    internal           = true
    load_balancer_type = "application"
    allow_lb_sg_cidr   = ["10.0.3.0/24", "10.0.4.0/24","10.0.5.0/24", "10.0.6.0/24"]
    subnet_ref         = "app"
    acm_https_arn      = null
    listener_port      = "80"
    listener_protocol  = "HTTP"
    ssl_policy         = null
  }

  public = {
    internal           = false
    load_balancer_type = "application"
    allow_lb_sg_cidr   = ["0.0.0.0/0"]
    subnet_ref         = "public"
    acm_https_arn      = "arn:aws:acm:us-east-1:932966355658:certificate/879c726b-aaf3-4b25-abc6-60596d4ae20b"
    listener_port      = "443"
    listener_protocol  = "HTTPS"
    ssl_policy         = "ELBSecurityPolicy-2016-08"
  }
}