vpc_cidr_block = "10.0.0.0/16"
vpc_instance_tenancy = "default"
tag_overlay = {
    Name = "ASG_network"
    Env = "dev"
    Project = "ASG"
    PM = "top Guru"

}

pub_subnet1_cidr_block = "10.0.1.0/24"
pub_subnet2_cidr_block = "10.0.2.0/24"
pub_subnet3_cidr_block = "10.0.5.0/24"
priv_subnet1_cidr_block = "10.0.3.0/24"
priv_subnet2_cidr_block = "10.0.4.0/24"
pub-RT1_cidr_block = "0.0.0.0/0"
pub-RT2_cidr_block = "0.0.0.0/0"
pub-RT3_cidr_block = "0.0.0.0/0"
priv-RT1_cidr_block = "0.0.0.0/0"
priv-RT2_cidr_block = "0.0.0.0/0"
pub_subnet1_az = "us-east-1a"
pub_subnet2_az = "us-east-1b"
pub_subnet3_az = "us-east-1c"
priv_subnet1_az = "us-east-1a"
priv_subnet2_az = "us-east-1b"
ami = "ami-00a929b66ed6e0de6"
# alb_sg_id = "sg-05846d71eef368679"
key_name      = "Pekay-keys"
# ASG_ec2_sg_id = "sg-0a1a8734e4da499f9"

# this file is used to assist the Jenkinsfile to create end to end pipeline for the Jenkins server