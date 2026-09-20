# AWS IAM Management with Terraform

## Project Overview

This project demonstrates how to manage AWS IAM users using **Terraform** and a **YAML configuration file**.

In this project:

- User and role information is provided through a YAML file.
- Terraform reads and processes the YAML file.
- IAM users are created automatically.
- Login passwords are generated for the users.
- AWS managed policies are attached according to the user's role.
- IAM users can be tested by logging into the AWS Console.
- Terraform can destroy all resources created by the project.

---

## Project Structure

```text
iam-mgmt/
├── main.tf
└── users.yaml
```

---

# 1. Create Project Directory

```bash
mkdir iam-mgmt
cd iam-mgmt
```

---

# 2. Create YAML File

Create the following file:

```text
users.yaml
```

Add the following configuration:

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

| Username | Role | AWS Managed Policy |
|---|---|---|
| vinay-sunhare | admin | AdministratorAccess |
| tarun | readonly | ReadOnlyAccess |
| tushar | ec2access | AmazonEC2FullAccess |

---

# 3. Create main.tf

Create the following file:

```text
main.tf
```

Add the following Terraform configuration:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Read users.yaml file
locals {
  users_data = yamldecode(file("./users.yaml")).users

  # Map YAML roles to AWS managed policy ARNs
  policy_map = {
    admin     = "arn:aws:iam::aws:policy/AdministratorAccess"
    readonly  = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    ec2access = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  }

  # Create username and role pairs
  user_role_pair = [
    for user in local.users_data : {
      username = user.username
      role     = user.role
    }
  ]
}

# Show users and roles
output "output" {
  value = local.user_role_pair
}

# Create IAM users
resource "aws_iam_user" "users" {
  for_each = {
    for user in local.users_data :
    user.username => user
  }

  name = each.value.username
}

# Create login profile/password for IAM users
resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users

  user            = each.value.name
  password_length = 15

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

# Attach policies according to user's role
resource "aws_iam_user_policy_attachment" "main" {
  for_each = {
    for user in local.users_data :
    "${user.username}-${user.role}" => user
  }

  user       = aws_iam_user.users[each.value.username].name
  policy_arn = local.policy_map[each.value.role]
}
```

---

# 4. Check Existing IAM Users

Before running Terraform, check the existing IAM users in AWS.

Initially, there were only two IAM users:

1. `admin`
2. `vinay-terraform-setup`

### AWS IAM Before Terraform Apply

<img width="512" height="105" alt="image" src="https://github.com/user-attachments/assets/741653ad-c868-4bfe-9d44-9cd5c2381fcd" />

---

# 5. Terraform Init

Save the files and run:

```bash
terraform init
```

Terraform will download the required AWS provider.

<img width="512" height="282" alt="image" src="https://github.com/user-attachments/assets/9664e7fc-bc87-4ade-92c6-703d772e9574" />

---
---

# 6. Terraform Plan

Run:

```bash
terraform plan
```
<img width="512" height="282" alt="image" src="https://github.com/user-attachments/assets/03ca85b8-e1a7-41dc-b5e4-defd654c4626" />


Terraform will read the `users.yaml` file and show which resources will be created.

The following IAM users will be created:

```text
vinay-sunhare
tarun
tushar
```

# 7. Check IAM Policy Access

Before applying Terraform, make sure the AWS credentials being used by Terraform have sufficient IAM permissions.

This project uses the following AWS managed policies:

```text
AdministratorAccess
ReadOnlyAccess
AmazonEC2FullAccess
```

Policy ARNs:

```text
arn:aws:iam::aws:policy/AdministratorAccess

arn:aws:iam::aws:policy/ReadOnlyAccess

arn:aws:iam::aws:policy/AmazonEC2FullAccess
```

The Terraform execution identity needs permissions to:

- Create IAM users
- Create IAM login profiles
- Attach IAM policies
- Read IAM policies

---

# 8. Terraform Apply

Now create the IAM users and attach their respective policies.

Run:

```bash
terraform apply
```

Terraform will ask for confirmation.

Enter:

```text
yes
```

Terraform will create:

```text
vinay-sunhare
tarun
tushar
```

and attach their respective policies.

<img width="512" height="233" alt="image" src="https://github.com/user-attachments/assets/2a367385-7457-4d33-ac50-e946512363a9" />


---

# 9. Verify IAM Users

Go to:

```text
AWS Console
    ↓
IAM
    ↓
Users
```

You should now see:

```text
vinay-sunhare
tarun
tushar
```
<img width="512" height="233" alt="image" src="https://github.com/user-attachments/assets/298c58e2-928b-4019-b222-938840e339fc" />

---

# 10. Check Generated Password

You can also inspect the state file:

```bash
cat terraform.tfstate
```

# 11. Login as IAM User

Now test the IAM users one by one.

Open another browser or an Incognito/Private window.

Use the AWS IAM Console login page and sign in using the generated IAM user's credentials.

---

# 12. Test Tarun User

The YAML configuration contains:

```yaml
- username: tarun
  role: readonly
```

The `readonly` role is mapped to:

```text
ReadOnlyAccess
```

Login using the `tarun` IAM credentials.

<img width="512" height="227" alt="image" src="https://github.com/user-attachments/assets/72ace693-6dc0-476b-90eb-88dde0dc9e83" />

---

# 13. Verify Tarun Permissions

Go to:

```text
AWS Console
    ↓
IAM
    ↓
Users
    ↓
tarun
    ↓
Permissions
```

The user should have:

```text
ReadOnlyAccess
```

The user should have read-only permissions according to the AWS managed policy.

<img width="512" height="227" alt="image" src="https://github.com/user-attachments/assets/5a188b37-7141-443a-b5f6-280194a08808" />

---

# 14. Test Vinay-Sunhare User

The YAML configuration contains:

```yaml
- username: vinay-sunhare
  role: admin
```

The `admin` role is mapped to:

```text
AdministratorAccess
```

Login using the `vinay-sunhare` IAM credentials.

<img width="512" height="227" alt="image" src="https://github.com/user-attachments/assets/7e91d1fe-2f3c-4478-967c-25b282360bc7" />


Verify the user's permissions:

```text
AWS Console
    ↓
IAM
    ↓
Users
    ↓
vinay-sunhare
    ↓
Permissions
```

The attached policy should be:

```text
AdministratorAccess
```
<img width="512" height="227" alt="image" src="https://github.com/user-attachments/assets/c3e1eeda-7bdf-4285-bef5-ccd8bc0df8e4" />

---

# 15. Terraform Destroy

After testing the project, remove all resources created by Terraform.

Run:

```bash
terraform destroy
```

Terraform will show the resources that will be deleted.

Enter:

```text
yes
```

Terraform will remove the IAM users and associated resources created by this configuration.

<img width="512" height="252" alt="image" src="https://github.com/user-attachments/assets/433eb1e7-2eab-4a3d-9580-5afb7fb2a7ab" />


---

# 16. Verify IAM Users Are Removed

Go to:

```text
AWS Console
    ↓
IAM
    ↓
Users
```

The Terraform-created users should now be removed:

```text
vinay-sunhare
tarun
tushar
```
<img width="512" height="92" alt="image" src="https://github.com/user-attachments/assets/ef549fc6-78d4-4ddd-96b6-df2a9bfb730d" />

---

# Complete Workflow

```text
users.yaml
     │
     ▼
Terraform
     │
     ▼
yamldecode()
     │
     ▼
Read Username + Role
     │
     ▼
Map Role to IAM Policy
     │
     ├── admin ────────► AdministratorAccess
     │
     ├── readonly ─────► ReadOnlyAccess
     │
     └── ec2access ────► AmazonEC2FullAccess
     │
     ▼
Create IAM Users
     │
     ▼
Generate Login Profiles
     │
     ▼
Attach IAM Policies
     │
     ▼
Test IAM Users
     │
     ▼
terraform destroy
     │
     ▼
Remove IAM Users
```

---

# Commands Used

## Create Project

```bash
mkdir iam-mgmt
cd iam-mgmt
```

## Initialize Terraform

```bash
terraform init
```

## Validate Configuration

```bash
terraform validate
```

## Check Changes

```bash
terraform plan
```

## Create IAM Resources

```bash
terraform apply
```

## Show Terraform State

```bash
terraform show
```

## Destroy IAM Resources

```bash
terraform destroy
```

---

# Technologies Used

- Terraform
- AWS IAM
- AWS Managed Policies
- YAML
- HCL
- AWS Console

---

# IAM User Configuration

| User | YAML Role | Attached Policy |
|---|---|---|
| `vinay-sunhare` | `admin` | `AdministratorAccess` |
| `tarun` | `readonly` | `ReadOnlyAccess` |
| `tushar` | `ec2access` | `AmazonEC2FullAccess` |

---

# Key Terraform Concepts

## YAML Decoding

Terraform reads the YAML configuration using:

```hcl
yamldecode(file("./users.yaml"))
```

---

## Local Values

The YAML data and policy mapping are stored using Terraform locals:

```hcl
locals {
  users_data = yamldecode(file("./users.yaml")).users
}
```

---

## for_each

Terraform uses `for_each` to dynamically create IAM users:

```hcl
resource "aws_iam_user" "users" {
  for_each = {
    for user in local.users_data :
    user.username => user
  }

  name = each.value.username
}
```

---

## Dynamic Policy Mapping

The YAML role is mapped to an AWS managed policy:

```hcl
policy_map = {
  admin     = "arn:aws:iam::aws:policy/AdministratorAccess"
  readonly  = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ec2access = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
```

This allows users and their roles to be managed from the YAML file without creating separate Terraform resources for every user.

---

# Security Considerations

This project is intended for learning and demonstration purposes.

For production environments:

- Do not expose generated IAM passwords.
- Never commit `terraform.tfstate` to GitHub.
- Store Terraform state in a secure remote backend.
- Enable encryption for the Terraform state backend.
- Use least-privilege IAM policies wherever possible.
- Avoid `AdministratorAccess` unless it is actually required.
- Prefer IAM roles and temporary credentials for workloads.
- Enable MFA for IAM users where applicable.
- Protect AWS root account credentials.
- Store secrets securely.
- Add Terraform state files to `.gitignore`.

---

# Add a New User

To add another IAM user, simply update `users.yaml`.

Example:

```yaml
users:
  - username: vinay-sunhare
    role: admin

  - username: tarun
    role: readonly

  - username: tushar
    role: ec2access

  - username: newuser
    role: readonly
```

Then run:

```bash
terraform plan
```

and:

```bash
terraform apply
```

Terraform will process the YAML file and create the new IAM user with the corresponding policy.

---

# Final Result

This project demonstrates how to automate AWS IAM user management using:

```text
YAML
  +
Terraform
  +
AWS IAM
  +
AWS Managed Policies
```

The complete process is automated:

```text
YAML Configuration
       ↓
Terraform Reads YAML
       ↓
IAM Users Created
       ↓
Passwords Generated
       ↓
Policies Attached
       ↓
Users Tested
       ↓
Terraform Destroy
       ↓
IAM Users Removed
```
