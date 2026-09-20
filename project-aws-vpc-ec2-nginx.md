# Project: VPC + EC2 + NGINX + HTTP Access

## Project Name

aws-vpc-ec2-nginx

---

## Project Overview

In this project, we will create the following AWS infrastructure using Terraform:

- AWS VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Table
- Route Table Association
- Security Group
- EC2 Instance
- NGINX Web Server
- HTTP Access on Port 80
- Terraform Outputs for Public IP and URL

Everything will be created using Terraform.

---

# Create New Folder

Create a new folder:

    mkdir aws-vpc-ec2-nginx
    cd aws-vpc-ec2-nginx

Create the following Terraform files:

    aws-vpc-ec2-nginx/
    │
    ├── main.tf
    ├── providers.tf
    ├── vpc.tf
    ├── ec2.tf
    ├── security-group.tf
    └── outputs.tf

---

# 1. main.tf

Create `main.tf`.

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}
```

---

# 2. providers.tf

Create `providers.tf`.

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

# 3. vpc.tf

Create `vpc.tf`.

```hcl
# Create a VPC

resource "aws_vpc" "vinaysunhare-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vinaysunhare-vpc"
  }
}


# Public Subnet

resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.vinaysunhare-vpc.id

  tags = {
    Name = "public-subnet"
  }
}


# Private Subnet

resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.vinaysunhare-vpc.id

  tags = {
    Name = "private-subnet"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "vinaysunhare-igw" {
  vpc_id = aws_vpc.vinaysunhare-vpc.id

  tags = {
    Name = "vinaysunhare-igw"
  }
}


# Route Table

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.vinaysunhare-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vinaysunhare-igw.id
  }
}


# Public Subnet Route Table Association

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id      = aws_subnet.public-subnet.id
}
```

---

# 4. ec2.tf

Create `ec2.tf`.

```hcl
# EC2 Instance for NGINX

resource "aws_instance" "nginx" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public-subnet.id

  vpc_security_group_ids = [
    aws_security_group.nginx-vs.id
  ]

  associate_public_ip_address = true

  # Install and configure NGINX

  user_data = <<-EOF
              #!/bin/bash

              sudo yum update -y

              sudo yum install nginx -y

              sudo systemctl start nginx

              sudo systemctl enable nginx

              echo '<h1>Welcome to NGINX on EC2 with Terraform Tutorial</h1>' | sudo tee /usr/share/nginx/html/index.html

              EOF

  tags = {
    Name = "nginx-vs"
  }
}
```

---

# 5. security-group.tf

Create `security-group.tf`.

```hcl
resource "aws_security_group" "nginx-vs" {
  vpc_id = aws_vpc.vinaysunhare-vpc.id

  # Inbound rule for HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-vs"
  }
}
```

---

# 6. outputs.tf

Create `outputs.tf`.

```hcl
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.nginx.public_ip
}

output "instance_url" {
  description = "The URL to access the Nginx server"
  value       = "http://${aws_instance.nginx.public_ip}"
}
```

---

# Project Structure

    aws-vpc-ec2-nginx/
    │
    ├── main.tf
    ├── providers.tf
    ├── vpc.tf
    ├── ec2.tf
    ├── security-group.tf
    └── outputs.tf

---

# Terraform Init

Run:

    terraform init

  <img width="512" height="282" alt="image" src="https://github.com/user-attachments/assets/4c4c6323-fbf0-4dfb-ad8a-808ed1cb3f81" />


Terraform will download the AWS provider.

---

# Terraform Validate

Run:

    terraform validate

  <img width="512" height="77" alt="image" src="https://github.com/user-attachments/assets/087bcdbf-f78e-447e-a067-3687ee65aca9" />


Expected result:

    Success! The configuration is valid.

# Terraform Apply

Run:

    terraform apply

Enter:

    yes

Terraform will create the complete AWS infrastructure.

---
<img width="512" height="96" alt="image" src="https://github.com/user-attachments/assets/0311e498-c2be-44a4-8e13-9e07295571a4" />


# AWS Credentials Error

Initially, you may get the following error:

    Error: No valid credential sources found

    Error: failed to refresh cached credentials,
    no EC2 IMDS role found

This happens because Terraform cannot find valid AWS credentials.

In this project, the AWS credentials are stored in the `.env` file.

---

# Load AWS Credentials

If the `.env` file is located one directory above the project, run:

    source ../.env

Then run:

    terraform apply

Enter:

    yes

---

<img width="512" height="323" alt="image" src="https://github.com/user-attachments/assets/6b4135bd-1ca5-4681-9863-a2d147713e13" />


# EC2 Instance Created Successfully

After `terraform apply` completes successfully, the EC2 instance will be created.

Go to:

    AWS Console
        ↓
    EC2
        ↓
    Instances

You should see:

    nginx-vs

The instance should be in the:

    Running

state.

---

# Check Public IP

Terraform will display the public IP address.

Example:

    instance_public_ip = "3.81.165.37"

Your public IP will be different.

<img width="512" height="112" alt="image" src="https://github.com/user-attachments/assets/d5f8f623-8fee-40a2-9ed1-a66184f63ade" />


You can also check the public IP from:

    AWS Console
        ↓
    EC2
        ↓
    Instances
        ↓
    nginx-vs
        ↓
    Public IPv4 address

---

# Access NGINX Using HTTP

Open the EC2 public IP in your browser:

    http://3.81.165.37/

Your IP address will be different.

Expected result:

    Welcome to NGINX on EC2 with Terraform Tutorial

---

<img width="512" height="105" alt="image" src="https://github.com/user-attachments/assets/b3c454ca-87a8-4128-9f0d-1a52a28c2a62" />


# HTTP Access

This project uses:

    HTTP

Port:

    80

Therefore, access the server using:

    http://<EC2-PUBLIC-IP>

Example:

    http://3.81.165.37/

This project does not configure HTTPS.

HTTPS would require additional configuration such as:

- SSL/TLS Certificate
- Domain Name
- Port 443
- HTTPS Configuration

---

# Terraform Output

Run:

    terraform output

Example:

    instance_public_ip = "3.81.165.37"
    instance_url       = "http://3.81.165.37"

You can also check only the public IP:

    terraform output instance_public_ip

Or only the URL:

    terraform output instance_url

---

# Destroy Infrastructure

After completing the practice, destroy the infrastructure to avoid unnecessary AWS charges.

Run:

    terraform destroy

Enter:

    yes

Terraform will remove all resources created by this project.

<img width="512" height="294" alt="image" src="https://github.com/user-attachments/assets/72833fd5-e785-447f-9db8-de6871c73dd9" />


---

# Verify EC2 Instance

After running:

    terraform destroy

Go to:

    AWS Console
        ↓
    EC2
        ↓
    Instances

The EC2 instance created by Terraform should no longer exist.

<img width="512" height="87" alt="image" src="https://github.com/user-attachments/assets/39fa3a17-e81c-409f-b386-424c5d0980e1" />


You can also verify that the following resources have been removed:

- EC2 Instance
- Security Group
- Public Subnet
- Private Subnet
- Route Table
- Internet Gateway
- VPC

---

# Complete Terraform Workflow

    cd aws-vpc-ec2-nginx

    source ../.env

    terraform init

    terraform validate

    terraform plan

    terraform apply

    terraform output

    terraform destroy

---

# Architecture

    Internet
        │
        │ HTTP :80
        ▼
    Internet Gateway
        │
        ▼
    Route Table
        │
        ▼
    VPC: 10.0.0.0/16
        │
        ├── Public Subnet
        │      10.0.2.0/24
        │          │
        │          ▼
        │     EC2 Instance
        │       t2.micro
        │          │
        │          ▼
        │        NGINX
        │          │
        │          ▼
        │       HTTP :80
        │
        └── Private Subnet
               10.0.1.0/24

---

# What We Learned

In this project, we practiced:

- Creating an AWS VPC using Terraform
- Creating a public subnet
- Creating a private subnet
- Creating an Internet Gateway
- Creating a route table
- Associating a route table with a public subnet
- Creating an AWS Security Group
- Allowing HTTP traffic on port 80
- Creating an EC2 instance
- Assigning a public IP to EC2
- Installing NGINX using Terraform `user_data`
- Hosting a simple web page using NGINX
- Accessing NGINX through the EC2 public IP
- Using Terraform outputs
- Loading AWS credentials using `.env`
- Running `terraform init`
- Running `terraform validate`
- Running `terraform plan`
- Running `terraform apply`
- Running `terraform destroy`

---

# Final Result

The final infrastructure is:

    Terraform
        │
        ▼
    AWS VPC
        │
        ├── Public Subnet
        │       │
        │       └── EC2
        │            │
        │            └── NGINX
        │                 │
        │                 └── HTTP :80
        │
        └── Private Subnet

The NGINX web server is accessible through:

    http://<EC2-PUBLIC-IP>

All infrastructure is created and destroyed using Terraform.
