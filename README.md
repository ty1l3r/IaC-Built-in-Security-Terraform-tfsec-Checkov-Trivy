- Rectification des nom et nombres des NAT GATWAY.


- INTERNET GATWAY
-Load Balancer est dans DES sous-réseau public


DEBUG :

------------------------


 Error: requesting ACM Certificate (yourdomain.com): operation error ACM: RequestCertificate, https response error StatusCode: 400, RequestID: 713bb35e-7dd7-4587-962d-3ab58bc06ac5, api error AccessDeniedException: User: arn:aws:iam::126316686161:user/terraform_user is not authorized to perform: acm:RequestCertificate on resource: arn:aws:acm:eu-west-3:126316686161:certificate/* because no identity-based policy allows the acm:RequestCertificate action
│
│   with module.alb.aws_acm_certificate.certificat,
│   on modules/alb/main.tf line 57, in resource "aws_acm_certificate" "certificat":
│   57: resource "aws_acm_certificate" "certificat" {

------------------------

│ Error: importing EC2 Key Pair (keypair): operation error EC2: ImportKeyPair, https response error StatusCode: 400, RequestID: 5084fa1a-b3bc-4470-a8b9-7a86547c7984, api error InvalidKeyPair.Duplicate: The keypair already exists
│
│   with module.ec2.aws_key_pair.myec2key,
│   on modules/ec2/main.tf line 4, in resource "aws_key_pair" "myec2key":
│    4: resource "aws_key_pair" "myec2key" {
│
------------------------

│ Error: creating RDS DB Instance (terraform-20240905075643191900000004): operation error RDS: CreateDBInstance, https response error StatusCode: 400, RequestID: 691d88b5-e422-4003-acc3-e0c639a39712, api error InvalidParameterValue: The parameter MasterUserPassword is not a valid password because it is shorter than 8 characters.
│
│   with module.rds.aws_db_instance.main,
│   on modules/rds/main.tf line 16, in resource "aws_db_instance" "main":
│   16: resource "aws_db_instance" "main" {

------------------------

Error: waiting for EC2 NAT Gateway (nat-08e7a67a34844a351) create: unexpected state 'failed', wanted target 'available'. last error: Gateway.NotAttached: Network vpc-0d827983965a9b5c7 has no Internet gateway attached
│
│   with module.vpc.aws_nat_gateway.gw_public_a,
│   on modules/vpc/main.tf line 49, in resource "aws_nat_gateway" "gw_public_a":
│   49: resource "aws_nat_gateway" "gw_public_a" {

------------------------

│ Error: waiting for EC2 NAT Gateway (nat-068ddcf7d838c4b38) create: unexpected state 'failed', wanted target 'available'. last error: Gateway.NotAttached: Network vpc-0d827983965a9b5c7 has no Internet gateway attached
│
│   with module.vpc.aws_nat_gateway.gw_public_b,
│   on modules/vpc/main.tf line 103, in resource "aws_nat_gateway" "gw_public_b":
│  103: resource "aws_nat_gateway" "gw_public_b" {


------------------------
Supression du vpc avec id : aws ec2 delete-vpc --vpc-id vpc-075d7129a250b342d

SECURITY GROUPS
#############################################################
sg-0d30844e891b98972
|+--------------+-------------------------------------------+|
||  Description |  default VPC security group               ||
||  GroupId     |  sg-0d30844e891b98972                     ||
||  GroupName   |  default                                  ||
||  OwnerId     |  126316686161                             ||
||  VpcId       |  vpc-01bc80d2486a8f7c3                    ||

#############################################################
sg-08a20b876d57f1b26
|+--------------+-------------------------------------------+|
||  Description |  default VPC security group               ||
||  GroupId     |  sg-08a20b876d57f1b26                     ||
||  GroupName   |  default                                  ||
||  OwnerId     |  126316686161                             ||
||  VpcId       |  vpc-01250fe8a7ae05e03                    ||

#############################################################
sg-080b9d55f0c4dd5be
|+--------------+-------------------------------------------+|
||  Description |  Allows inbound access from the ALB only  ||
||  GroupId     |  sg-080b9d55f0c4dd5be                     ||
||  GroupName   |  ec2_security_group                       ||
||  OwnerId     |  126316686161                             ||
||  VpcId       |  vpc-0d28f2522df70c57f                    ||

#############################################################
sg-0d852d5ca6c909ebc
|+--------------+-------------------------------------------+|
||  Description |  default VPC security group               ||
||  GroupId     |  sg-0d852d5ca6c909ebc                      ||
||  GroupName   |  default                                  ||
||  OwnerId     |  126316686161                             ||
||  VpcId       |  vpc-0d28f2522df70c57f                    ||
#############################################################
sg-0e4164f6c25c1a7f8
|+--------------+-------------------------------------------+|
||  Description |  default VPC security group               ||
||  GroupId     |  sg-0e4164f6c25c1a7f8                      ||
||  GroupName   |  default                                  ||
||  OwnerId     |  126316686161                             ||
||  VpcId       |  vpc-00c1ac2d8a8db8511                   ||
#############################################################
sg-028fd783776630f54
|+--------------+-------------------------------------------+|
||  Description |  Controls access to the ALB               ||
||  GroupId     |  sg-028fd783776630f54                      ||
||  GroupName   |  load_balancer_security_group           ||
||  OwnerId     |  126316686161                             ||
||  VpcId       |  vpc-0d28f2522df70c57f                  ||


DESCRIBE SUBNETS :
aws ec2 describe-subnets --query 'Subnets[*].{ID:SubnetId,VPC:VpcId,CIDR:CidrBlock}' --output table
10.0.144.0/20|  subnet-045da5e92a3ac21eb  |  vpc-075d7129a250b342d  |
|  10.0.128.0/20|  subnet-095b24eea5de7fbaa  |  vpc-075d7129a250b342d  |
|  10.0.0.0/19  |  subnet-005190b170dfeb6c7  |  vpc-075d7129a250b342d  |
|  10.0.32.0/19 |  subnet-0ef88521f1f017047  |  vpc-075d7129a250b342d

