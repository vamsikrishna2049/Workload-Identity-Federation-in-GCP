project_id                = "mystic-centaur-297207"
region                    = "us-central1"

#VPC
vpc_name                  = "my-custom-vpc-network"
routing_mode              = "REGIONAL"
auto_create_subnetworks   = false

#Subnets
subnet_name               = "primary-subnet-us-central1"
ip_cidr_range             = "10.10.1.0/24"
