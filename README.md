- Rectification des nom et nombres des NAT GATWAY.




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

