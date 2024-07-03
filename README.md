# Terraform AWS EC2 Project

This project sets up a simple AWS environment using Terraform, creating a VPC with public and private subnets, and provisioning an EC2 instance. Additionally, it configures Ansible for managing the EC2 instance.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI installed and configured with the appropriate profile
- Ansible installed

## Configuration

1. **Clone the repository**

   ```sh
   git clone https://github.com/nexomis/tf-single-ec2.git
   cd tf-single-ec2
   ```

2. **Create a `backend.tf` file** (optional, if you want to use remote state storage with S3)

   ```hcl
   terraform {
     backend "s3" {
       region = "eu-west-3"
       bucket = "XXXXXXXXXXXXXXXXXXXX"
       key    = "YYYYYYY.tfstate"
     }
   }
   ```

3. **Create a `main.auto.tfvars` file** to specify variables with no default values. Here is an example:

   ```hcl
   region         = "eu-west-3"
   prefix         = "example"
   aws_profile    = "example-profile"
   instance_type  = "t3a.xlarge"
   volume_size    = 200
   ```

Default variabvles are set in `variables.tf`


## Deploying the Infrastructure

1. **Initialize Terraform**

   ```sh
   terraform init
   ```

2. **Validate the Terraform configuration**

   ```sh
   terraform validate
   ```

3. **Apply the Terraform configuration**

   ```sh
   terraform apply
   ```

   Type `yes` to confirm the apply.

## Notes

- Ensure that the AWS CLI profile specified in `main.auto.tfvars` has the necessary permissions to create the resources.
- The `ansible_dir` in the `ansible_project` module should point to the directory where your Ansible playbooks are located.
- Customize the security group rules, instance type, and other parameters as needed.

## Cleanup

To destroy the resources created by Terraform, run:

```sh
terraform destroy
```

Type `yes` to confirm the destroy.

This README provides a step-by-step guide to setting up and deploying the infrastructure using Terraform. Adjust variable values and configurations as needed for your specific use case.


