# for_each
This repository contains code that uses for_each to create multiple resources

# What is this repo intended for
This repo is intended to show how the for_each operator works. for_each can used when you need multiple resources and they only differe by one or two parameters.

# Why use this repo
With this repo you will get an overview of how for_each works  and you will be able to find out where to use it in your own work.

# How to use this repository

* Create a user in AWS, you require these two keys in order to be able to create resources in AWS
 ```
 AWS_ACCESS_KEY_ID
 AWS_SECRET_ACCESS_KEY
 ```
 * To use them you have to set them as environment variables by putting these two lines in ~/.bash_profile
 ```
 export AWS_ACCESS_KEY_ID=*your key id*
 export AWS_SECRET_ACCESS_KEY=*your access key*
 ```
 * Install Terraform
 ```
 https://www.terraform.io/downloads.html
 ```
 
 * Clone this repository
 
 ```
 git clone https://github.com/yordanivh/for_each
 ```
 
 * Change directory
 
 ```
 cd for_each
 ```
 
 * Initialize the project ( Terraform will download provider plugins)
 
 ```
 terraform init
 ```
* Check the code
```
cat main.tf
```
* We use for_each to go through a map
```hcl

for_each = {
resource "aws_instance" "example" {
  instance_type = "t2.micro"
  for_each = {

    server1_jordan = "ami-0520e698dd500b1d1"
    server2_jordan = "ami-0d5d9d301c853a04a"
  }

  ami = each.value
  tags = {
    name = each.key
  }
}
 ```
 What this code does is assign to the ami variable each value in the map and assign to a tag name each key in the map.
 This creates two resources which have the name and corresponding ami id.
 
 * In the code we have also utilised an output
 ```hcl
 output "EC2_instance_information" {
  value = "${formatlist(
    "%s = %s", 
    (values(aws_instance.example)[*].tags.name),
    (values(aws_instance.example)[*].ami)
  )}"
  }
  ```
  This output will show the server name equal to the ami used for it
  
  * Sample output is 
  ```hcl
  Outputs:

  EC2_instance_information = [
    "server1_jordan = ami-0520e698dd500b1d1",
    "server2_jordan = ami-0d5d9d301c853a04a",
  ]
  ```
  
  * After this you can start plan so that you see what actions will be taken
 
  ```
   terraform plan
   ```
 
   * Run Terraform apply to create the resources
 
   ```
   terraform apply
   ```
  * To destroy the created resources. Allways run this after testing this code to avoid being charged.

  ```
  terraform destroy
  ```

# Sample output

1.Run init to download necessary plugins
```
for_each (newbranch) $ terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.42.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.42"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
2. Run plan to get a plan of action.
```
for_each (newbranch) $ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.example["server1_jordan"] will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0520e698dd500b1d1"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "name" = "server1_jordan"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.example["server2_jordan"] will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0d5d9d301c853a04a"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "name" = "server2_jordan"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
3.Run apply to apply the plan of action
```
for_each (newbranch) $ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.example["server1_jordan"] will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0520e698dd500b1d1"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "name" = "server1_jordan"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.example["server2_jordan"] will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0d5d9d301c853a04a"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "name" = "server2_jordan"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.example["server1_jordan"]: Creating...
aws_instance.example["server2_jordan"]: Creating...
aws_instance.example["server1_jordan"]: Still creating... [10s elapsed]
aws_instance.example["server2_jordan"]: Still creating... [10s elapsed]
aws_instance.example["server1_jordan"]: Still creating... [20s elapsed]
aws_instance.example["server2_jordan"]: Still creating... [20s elapsed]
aws_instance.example["server2_jordan"]: Creation complete after 29s [id=i-0aa905fed1cc4891c]
aws_instance.example["server1_jordan"]: Creation complete after 29s [id=i-0fa187381f08f744c]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

EC2_instance_information = [
  "server1_jordan = ami-0520e698dd500b1d1",
  "server2_jordan = ami-0d5d9d301c853a04a",
]
```
4. Run destroy to terminate the resources.
```
for_each (newbranch) $ terraform destroy
aws_instance.example["server2_jordan"]: Refreshing state... [id=i-0aa905fed1cc4891c]
aws_instance.example["server1_jordan"]: Refreshing state... [id=i-0fa187381f08f744c]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.example["server1_jordan"] will be destroyed
  - resource "aws_instance" "example" {
      - ami                          = "ami-0520e698dd500b1d1" -> null
      - arn                          = "arn:aws:ec2:us-east-2:938620692197:instance/i-0fa187381f08f744c" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "us-east-2a" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-0fa187381f08f744c" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-05aa078891ae3f370" -> null
      - private_dns                  = "ip-172-31-2-158.us-east-2.compute.internal" -> null
      - private_ip                   = "172.31.2.158" -> null
      - public_dns                   = "ec2-3-15-17-170.us-east-2.compute.amazonaws.com" -> null
      - public_ip                    = "3.15.17.170" -> null
      - security_groups              = [
          - "default",
        ] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-c4534bac" -> null
      - tags                         = {
          - "name" = "server1_jordan"
        } -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-879339e5",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-0fc33caaa61946088" -> null
          - volume_size           = 10 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # aws_instance.example["server2_jordan"] will be destroyed
  - resource "aws_instance" "example" {
      - ami                          = "ami-0d5d9d301c853a04a" -> null
      - arn                          = "arn:aws:ec2:us-east-2:938620692197:instance/i-0aa905fed1cc4891c" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "us-east-2a" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-0aa905fed1cc4891c" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-0e1a4c1cf51e05daa" -> null
      - private_dns                  = "ip-172-31-15-70.us-east-2.compute.internal" -> null
      - private_ip                   = "172.31.15.70" -> null
      - public_dns                   = "ec2-3-135-191-0.us-east-2.compute.amazonaws.com" -> null
      - public_ip                    = "3.135.191.0" -> null
      - security_groups              = [
          - "default",
        ] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-c4534bac" -> null
      - tags                         = {
          - "name" = "server2_jordan"
        } -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-879339e5",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-05ba48a27999b84f2" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.example["server1_jordan"]: Destroying... [id=i-0fa187381f08f744c]
aws_instance.example["server2_jordan"]: Destroying... [id=i-0aa905fed1cc4891c]
aws_instance.example["server2_jordan"]: Still destroying... [id=i-0aa905fed1cc4891c, 10s elapsed]
aws_instance.example["server1_jordan"]: Still destroying... [id=i-0fa187381f08f744c, 10s elapsed]
aws_instance.example["server1_jordan"]: Still destroying... [id=i-0fa187381f08f744c, 20s elapsed]
aws_instance.example["server2_jordan"]: Still destroying... [id=i-0aa905fed1cc4891c, 20s elapsed]
aws_instance.example["server2_jordan"]: Destruction complete after 22s
aws_instance.example["server1_jordan"]: Still destroying... [id=i-0fa187381f08f744c, 30s elapsed]
aws_instance.example["server1_jordan"]: Destruction complete after 33s

Destroy complete! Resources: 2 destroyed.
```
