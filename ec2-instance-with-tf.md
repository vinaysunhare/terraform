# EC2 Instance with Terraform

## 1. Install Terraform Extension in VS Code

Go to **VS Code**.

Open **Extensions** or search for:

**HashiCorp Terraform v2.40.0**

> Version may change according to the time.

Click on **Install**.

<img width="512" height="111" alt="image" src="https://github.com/user-attachments/assets/a64c1341-0ef6-43c9-82f1-af959057610f" />

---

## 2. Why Are We Using Terraform?

We will use Terraform to create an **EC2 instance**.

If we need to create one or two EC2 instances, we can create them manually from the AWS Console.

But if we need to create many EC2 instances, doing everything manually will:

- Take too much time
- Increase the possibility of human mistakes
- Require repeating the same configuration
- Make infrastructure management more difficult

With Terraform, we can write infrastructure as code and reuse the same code multiple times.

We can also modify the configuration according to our requirements and run it again.

This is one of the main benefits of **Infrastructure as Code (IaC)**.

---

## 3. Get AMI ID and Instance Type

To create an EC2 instance, we need:

- AMI ID
- Instance type
- AWS region

Go to your **AWS account**.

1. Go to **EC2**
2. Click **Launch Instance**
3. Select the operating system you want to use
4. Check the **AMI ID**
5. Select the required **Instance Type**

You can also use the AMI ID and instance type already provided in the code below.

> **Note:** AMI IDs are region-specific and can change over time. Always verify that the AMI ID is available in the AWS region you are using.

---

## 4. Important: Give Permission to the IAM User

Before running Terraform, make sure that the AWS IAM user being used by Terraform has the required permissions.

### Important Reminder

I initially forgot to give the required permission to my IAM user.

Because of this, Terraform could not create the EC2 instance.

I then added the required permission to the IAM user and continued with the Terraform process.

> **Always check your IAM user permissions before running `terraform apply`.**

For this example, the IAM user needs the required EC2 permissions to create and manage the EC2 instance.

---

## 5. Create the Terraform File

Open VS Code and create a new file:

`ec2-instance-with-terraform.tf`

Add the following Terraform configuration:

    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "5.66.0"
        }
      }
    }

    provider "aws" {
      # We use AWS now
      region = "us-east-1" # We will create the EC2 instance in us-east-1
    }

    resource "aws_instance" "vinaywebserver" {
      ami           = "ami-0e86e20dae9224db8" # AMI ID - our Linux image
      instance_type = "t2.micro"               # We use the t2.micro instance type

      tags = {
        Name = "vinay-ec2-instance-with-terraform" # EC2 instance name
      }
    }

---

## 6. Initialize Terraform

Open the terminal in VS Code.

Run:

    terraform init

`terraform init` initializes the Terraform working directory and downloads the required AWS provider.

After running the command, Terraform should initialize successfully.

<img width="512" height="273" alt="image" src="https://github.com/user-attachments/assets/a9b665ec-66b5-4b62-b738-7309d426601d" />

---

## 7. Run Terraform Plan

Before creating the EC2 instance, run:

    terraform plan

<img width="512" height="372" alt="image" src="https://github.com/user-attachments/assets/457fbef8-f219-4356-b53d-e8272831daaa" />


The `terraform plan` command shows what Terraform is going to create, modify, or destroy.

This allows us to check the changes before actually applying them.

At this point, I don't have any EC2 instance running that was created by this Terraform configuration.

---

## 8. Create the EC2 Instance

Now run:

    terraform apply

<img width="512" height="384" alt="image" src="https://github.com/user-attachments/assets/03d8c33f-6e1f-4b65-9f6f-42c84a998efe" />


Terraform will show the resources that it is going to create.

Terraform will ask for confirmation.

Type:

    yes

Then press **Enter**.

<img width="512" height="370" alt="image" src="https://github.com/user-attachments/assets/80b1773c-c0e9-436c-854f-3984f75812c6" />


Terraform will create the EC2 instance according to our configuration.

---

## 9. Verify the EC2 Instance

Go to:

**AWS Console → EC2 → Instances**

Now our EC2 instance should be running.

The instance name should be:

    vinay-ec2-instance-with-terraform

<img width="512" height="113" alt="image" src="https://github.com/user-attachments/assets/f6107a84-96e2-4d89-b85a-f69875638201" />


The EC2 instance has now been created using Terraform instead of manually creating it from the AWS Console.

---

## 10. Destroy the EC2 Instance

When we no longer need the EC2 instance, we can destroy the infrastructure created by Terraform.

Run:

    terraform destroy

<img width="512" height="427" alt="image" src="https://github.com/user-attachments/assets/78bd243e-34e7-43b1-8f7f-5ce45fd7f1ef" />


Terraform will show the resources that are going to be deleted.

Terraform will ask for confirmation.

Type:

    yes

Then press **Enter**.

Terraform will destroy the EC2 instance created by this configuration.

<img width="512" height="98" alt="image" src="https://github.com/user-attachments/assets/a858c60f-5753-44ed-91c0-4afbac3a209a" />


---

# Terraform Workflow

The basic Terraform workflow used in this project is:

    Write Terraform Configuration
                ↓
          terraform init
                ↓
          terraform plan
                ↓
          terraform apply
                ↓
        EC2 Instance Created
                ↓
         terraform destroy
                ↓
        EC2 Instance Deleted

---

# Terraform Commands Used

    terraform init
    terraform plan
    terraform apply
    terraform destroy

---

# Conclusion

In this project, we created an **AWS EC2 instance using Terraform**.

Instead of manually creating the EC2 instance from the AWS Console, we defined the infrastructure in Terraform code.

This demonstrates the basic concept of **Infrastructure as Code (IaC)** and shows how Terraform can be used to automate AWS infrastructure creation and management.
