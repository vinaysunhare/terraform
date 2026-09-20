# Terraform AWS Projects

Hands-on **Terraform and AWS Infrastructure as Code (IaC)** projects for learning and practicing cloud infrastructure automation.

This repository contains practical Terraform configurations and step-by-step documentation covering **AWS EC2, VPC, S3, IAM, networking, security, and Terraform setup**.

---

## 🚀 Technologies & Tools

* Terraform
* AWS
* AWS EC2
* AWS VPC
* AWS S3
* AWS IAM
* AWS Security Groups
* YAML
* HCL
* Linux
* Git & GitHub

---

# 📂 Projects & Documentation

## 1. AWS VPC + EC2 + NGINX

A hands-on AWS infrastructure project that creates a VPC environment and deploys an NGINX web server on an EC2 instance using Terraform.

### Concepts Covered

* AWS VPC
* Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group
* EC2 Instance
* NGINX
* HTTP Access
* Terraform Outputs
* Infrastructure provisioning and destruction

### Documentation

[View AWS VPC + EC2 + NGINX Project](./project-aws-vpc-ec2-nginx.md)

---

## 2. AWS IAM User Management with Terraform

An automated AWS IAM user management project using **Terraform and YAML**.

User and role information is defined in a YAML file, which Terraform reads and processes to dynamically create IAM users and attach AWS managed policies.

### Features

* YAML-based user configuration
* Dynamic IAM user creation
* IAM login profiles
* Password generation
* Role-based policy mapping
* AWS managed policy attachment
* Terraform `for_each`
* Terraform `locals`
* YAML decoding with `yamldecode()`

### Example Configuration

```yaml
users:
  - username: vinay-sunhare
    role: admin

  - username: tarun
    role: readonly

  - username: tushar
    role: ec2access
```

### Role Mapping

| Role        | AWS Managed Policy    |
| ----------- | --------------------- |
| `admin`     | `AdministratorAccess` |
| `readonly`  | `ReadOnlyAccess`      |
| `ec2access` | `AmazonEC2FullAccess` |

### Documentation

[View IAM User Management Project](./project-iam-user-management.md)

---

## 3. Terraform AWS S3 Restaurant Website

A Terraform project that creates and configures an AWS S3 static website.

The infrastructure and website-related S3 configuration are managed through Terraform instead of manually configuring the resources from the AWS Console.

### Concepts Covered

* AWS S3
* S3 Bucket
* Static Website Hosting
* Public Access Configuration
* Bucket Policy
* Website files
* Terraform resource management

### Documentation

[View S3 Restaurant Website Project](./project-terraform-aws-s3-restaurant-website.md)

---

## 4. AWS S3 Bucket with Terraform

A basic Terraform project for creating and managing an AWS S3 bucket.

This project focuses on the fundamentals of provisioning AWS S3 infrastructure using Terraform.

### Concepts Covered

* AWS Provider
* S3 Bucket
* Terraform Resource
* Terraform Init
* Terraform Plan
* Terraform Apply
* Terraform Destroy

### Documentation

[View S3 Bucket Project](./s3-bucket-with-terraform.md)

---

## 5. EC2 Instance with Terraform

A basic AWS EC2 project demonstrating how to provision an EC2 instance using Terraform.

The repository contains both the Terraform configuration and documentation for creating and managing an EC2 instance.

### Files

* [`ec2-instance-with-terraform.tf`](./ec2-instance-with-terraform.tf)
* [`ec2-instance-with-tf.md`](./ec2-instance-with-tf.md)

### Concepts Covered

* AWS Provider
* EC2 Instance
* AMI
* Instance Type
* AWS Region
* Terraform Resources
* Terraform Configuration
* Infrastructure provisioning

### Documentation

[View EC2 Instance Guide](./ec2-instance-with-tf.md)

---

# 🔐 AWS IAM Access for Terraform

The repository also contains documentation for configuring AWS IAM access for Terraform.

The guide covers:

* AWS IAM user
* IAM group
* IAM policies
* AWS access keys
* AWS CLI installation
* AWS CLI configuration
* Authentication
* Terraform AWS provider access

### Documentation

[View AWS IAM Access Guide](./AWS-IAM-Access.md)

---

# 📦 Terraform Installation

The repository contains a step-by-step Terraform installation guide.

It includes:

* Terraform installation
* Version verification
* Terraform command verification

### Documentation

[View Terraform Installation Guide](./install-terraform.md)

---

# 🔄 Terraform Workflow

The projects in this repository follow the standard Terraform Infrastructure as Code workflow:

```text
Terraform Configuration
        │
        ▼
terraform init
        │
        ▼
terraform validate
        │
        ▼
terraform fmt
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
AWS Infrastructure
        │
        ▼
terraform destroy
```

---

# 🛠️ Common Terraform Commands

## Initialize Terraform

```bash
terraform init
```

Initializes the Terraform working directory and downloads the required providers.

---

## Validate Configuration

```bash
terraform validate
```

Checks whether the Terraform configuration is valid.

---

## Format Terraform Files

```bash
terraform fmt
```

Formats Terraform configuration files according to Terraform's standard formatting.

---

## Create an Execution Plan

```bash
terraform plan
```

Shows the infrastructure changes Terraform plans to make.

---

## Apply Configuration

```bash
terraform apply
```

Creates or updates the AWS infrastructure defined in the Terraform configuration.

---

## Destroy Infrastructure

```bash
terraform destroy
```

Removes the infrastructure managed by Terraform.

---

# 🧠 Terraform Concepts Practiced

This repository focuses on practical Terraform concepts including:

* Terraform Providers
* Terraform Resources
* Local Values
* Outputs
* `for_each`
* `for` expressions
* `yamldecode()`
* `file()`
* Resource dependencies
* Terraform State
* Lifecycle configuration
* AWS Provider
* Infrastructure provisioning
* Infrastructure destruction

---

# ☁️ AWS Services Covered

### Compute

* EC2

### Networking

* VPC
* Subnets
* Internet Gateway
* Route Tables
* Security Groups

### Storage

* S3
* S3 Static Website Hosting

### Identity & Access Management

* IAM Users
* IAM Groups
* IAM Policies
* IAM Login Profiles
* IAM Access Keys
* Role-based policy mapping

---

# 📁 Repository Structure

```text
terraform/
│
├── terraform/
│
├── AWS-IAM-Access.md
│
├── README.md
│
├── ec2-instance-with-terraform.tf
│
├── ec2-instance-with-tf.md
│
├── install-terraform.md
│
├── project-aws-vpc-ec2-nginx.md
│
├── project-iam-user-management.md
│
├── project-terraform-aws-s3-restaurant-website.md
│
└── s3-bucket-with-terraform.md
```

---

# 🔒 Security Notes

This repository is intended for learning and hands-on practice.

### Never commit:

```text
AWS Access Keys
AWS Secret Keys
.env files
terraform.tfstate
terraform.tfstate.backup
```

Add sensitive Terraform files to `.gitignore`:

```gitignore
.terraform/
terraform.tfstate
terraform.tfstate.backup
*.tfstate
*.tfstate.*
.env
```

For production environments:

* Follow the principle of least privilege.
* Avoid unnecessary `FullAccess` policies.
* Use IAM roles where appropriate.
* Protect AWS credentials.
* Use a secure remote Terraform backend.
* Encrypt Terraform state.
* Enable MFA where applicable.
* Never expose secrets in source code.

---

# 🎯 Learning Objectives

The main objective of this repository is to build practical experience with:

```text
AWS
 +
Terraform
 +
Infrastructure as Code
 +
Cloud Automation
 +
DevOps
```

The projects progress from basic Terraform resources to more practical AWS infrastructure automation.

---

# 👨‍💻 Author

## Vinay Sunhare

DevOps & Cloud Infrastructure Learner

GitHub:

https://github.com/vinaysunhare

---

# ⭐ Repository

This repository contains hands-on Terraform projects for learning and practicing **AWS Infrastructure as Code**.

Explore the individual project documentation to understand how each AWS infrastructure component is created, configured, tested, and managed using Terraform.

---

## Terraform + AWS + Infrastructure as Code

```text
Learn
  ↓
Build
  ↓
Automate
  ↓
Deploy
  ↓
Manage Infrastructure as Code
```
