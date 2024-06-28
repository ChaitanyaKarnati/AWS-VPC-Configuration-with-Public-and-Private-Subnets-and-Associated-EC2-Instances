# Automated Deployment of AWS VPC with Public and Private Subnet using Terraform


This Terraform script automates the setup of a two-tier application architecture on AWS. Web servers are deployed in the public subnet to interact with clients over the internet, while database/backend servers are placed in the private subnet for enhanced security. The script configures networking components such as VPC, subnets, gateways, and security groups, facilitating the creation of a scalable and secure infrastructure for hosting web applications. Automates the deployment of an AWS Virtual Private Cloud (VPC) with both public and private subnets, along with necessary networking components and EC2 instances. The infrastructure is provisioned efficiently, enabling users to establish a robust and scalable environment on AWS.

## Features

- **Automated Deployment:** The main.tf file contains Terraform configurations to provision all required AWS resources, including VPC, subnets, gateways, route tables, security groups, and EC2 instances.
  
- **Flexible Configuration:** Customize the VPC settings, subnet CIDR blocks, instance types, and other parameters to match your specific requirements.

- **Security Measures:** Security groups are configured to control inbound and outbound traffic, ensuring a secure environment. Additionally, public and private subnets are established to segregate resources as per best practices.

- **High Availability:** The infrastructure is designed with redundancy and fault tolerance in mind, leveraging multiple availability zones and NAT gateways for resilient connectivity.

## Usage

1. **Clone the Repository:** Start by cloning this repository to your local machine using the command:

    ```bash
    git clone https://github.com/Tarun-Chand-Illapu/Automated-Deployment-of-AWS-VPC-using-Terraform.git
    ```


2. **Deployment:** Initialize the Terraform configuration and apply it to create the infrastructure on AWS:

    ```bash
    terraform init
    terraform apply
    ```

4. **Management:** After deployment, Terraform will provide outputs including the public IP addresses of the EC2 instances. You can manage the infrastructure using Terraform commands, such as `terraform plan` and `terraform destroy`.

## Contributing

Contributions are welcome! If you encounter any issues, have suggestions for improvements, or want to contribute enhancements, feel free to open an issue or create a pull request. Please adhere to the [contributing guidelines](CONTRIBUTING.md) for smooth collaboration.



**Note:** Ensure you have Terraform installed locally and AWS CLI configured with appropriate credentials before deploying the infrastructure.
