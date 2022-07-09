## Main Terrafrom

Configuration in this directory creates VPCs, subnets, security groups, VPC peering connections, and route tables, with compatible CIDR blocks. It also contains code to image and deploy existing EC2 instances to existing ECS Clusters.

## Notes

To deploy this code, you will need to install Terraform CLI, and have AWS CLI installed and configured. Terraform can utilize the access key and secret access key used to configure AWS, or you can specify a separate set of credentials in the files themselves. DO NOT hard code any credentials in a file that you are managing with git. Create a separate terraform file and gitignore it. 

## Usage
To run:
clone this directory
```bash
$ terraform init
$ terraform plan
$ terraform apply
```
Take note of the new instance IDs and update the startup, shutdown, and freedns scripts in gitlab.



Running 'terraform verify' after any changes will find syntax errors faster than 'terraform apply'

## Improvements

Security groups leave all internal access open for all instances. This is because all sites see all traffic as coming from the VPN, which acts as a jump host. Implementing a 'zero-trust' model would improve security, but would require substantial changes to the VPN

Transit Gateway (TGW) would increase cost but would allow central routing instead of the mesh network that VPC peering currently provides. This may become necessary should the amount of cross-traffic increase drastically. Please see the article below for an excellent discussion of costs between various services. 
https://cloudonaut.io/advanved-aws-networking-pitfalls-that-you-should-avoid/

Terraform is capable of outputting instance id's or any other ARN when completed. Startup, shutdown, and DNS updating scripts are hard-coded with instance id's and will thus need updates for the newly created instances. A Jenkins job (or AWS Lamda function) could likely be set up to do this all at once.