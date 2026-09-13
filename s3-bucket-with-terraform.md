# AWS S3 Bucket

## AWS S3

AWS S3 (Amazon Simple Storage Service) is an object storage service provided by AWS. We can use S3 to store data such as files, images, videos, backups, and application data.

It is scalable, highly available, secure, and web-based cloud storage.

The cost of S3 depends on usage.

> **Note:** This is only for practice and hands-on experience with creating an S3 bucket using Terraform.

## IAM Permission

Before creating the S3 bucket with Terraform, make sure the IAM user used by Terraform has the required S3 permissions.

For this practice, I have provided:

**AmazonS3FullAccess**

[AmazonS3FullAccess](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonS3FullAccess)

> **Security Note:** In a production environment, avoid using full S3 access when it is not required. Follow the principle of least privilege.

---

# Create S3 Bucket Using Terraform

Now we are creating an S3 bucket automatically using Terraform.

## Step 1: Create a New Folder

Go to VS Code.

Create a new Terraform file inside this folder:

    vinay-s3-with-terraform.tf

Our folder structure will look like:

    ├── vinay-s3-with-terraform.tf
    └── vinaysunharetf.txt

---

# Step 2: Terraform Configuration

Add the following Terraform configuration to `vinay-s3-with-terraform.tf`:

    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "5.66.0"
        }

        random = {
          source  = "hashicorp/random"
          version = "3.6.2"
        }
      }
    }

    provider "aws" {
      # Cloud platform
      region = "us-east-1" # Region where we want to create the S3 bucket
    }

    resource "random_id" "random_id" {
      # Generate a random ID
      byte_length = 10
    }

    resource "aws_s3_bucket" "sunhare_bucket" {
      # Create an S3 bucket with a random ID
      bucket = "sunhare-bucket-${random_id.random_id.hex}"
    }

    resource "aws_s3_object" "bucket_txt_file" {
      # Upload the text file to the S3 bucket
      bucket = aws_s3_bucket.sunhare_bucket.id
      source = "./vinaysunharetf.txt"
      key    = "mydata.txt"
    }

    output "name" {
      # Display the random ID after terraform apply
      value = random_id.random_id.hex
    }

---

# Step 3: Terraform Random ID

We are using the Terraform Random provider to generate a random ID.

This is useful because S3 bucket names must be globally unique.

Go to the Terraform Registry:

https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id

For the `random_id` resource, use:

    resource "random_id" "random_id" {
      byte_length = 10
    }

This generates a random hexadecimal ID.

For example:

    a1b2c3d4e5f6

The generated ID is added to our S3 bucket name:

    sunhare-bucket-a1b2c3d4e5f6

This helps us create a unique S3 bucket name.

---

# Step 4: Output Block

We can use the Terraform `output` block to display the generated random ID.

    output "name" {
      value = random_id.random_id.hex
    }

After running `terraform apply`, Terraform will display the generated random ID.

Example:

    name = "a1b2c3d4e5f6"

---

# Step 5: Create the S3 Bucket Name

Our S3 bucket resource is:

    resource "aws_s3_bucket" "sunhare_bucket" {
      bucket = "sunhare-bucket-${random_id.random_id.hex}"
    }

The bucket name will look similar to:

    sunhare-bucket-a1b2c3d4e5f6

Because the random ID is different, the bucket name will also be unique.

---

# Step 6: Terraform Init

Open the terminal in VS Code.

Now run:

    terraform init

<img width="512" height="253" alt="image" src="https://github.com/user-attachments/assets/c4bf7836-5ce2-4c7f-9e13-11faefba1513" />


Terraform will download the required providers:

- AWS provider
- Random provider

You should see a message similar to:

    Terraform has been successfully initialized!

---

# Step 7: Create the S3 Bucket

Now run:

    terraform apply

<img width="512" height="163" alt="image" src="https://github.com/user-attachments/assets/7589b2c8-734c-4136-81a2-189800f54712" />

<img width="512" height="125" alt="image" src="https://github.com/user-attachments/assets/b94a9e3b-25e5-42ba-90bb-49b023300b59" />

Our S3 bucket is being created, but our text file is not available in our local directory, so let's create `vinaysunharetf.txt`.

Go to VS Code and create a new file named:

    vinaysunharetf.txt

Make sure it is in the same directory as the Terraform file.

Our directory should now look like:

    ├── vinay-s3-with-terraform.tf
    └── vinaysunharetf.txt

---

# Step 8: Add Content to the Text File

Open:

    vinaysunharetf.txt

Add some text, for example:

    Hello everyone, this is only for practice and hands-on experience in creating an S3 bucket with Terraform.

Save the file.

<img width="512" height="129" alt="image" src="https://github.com/user-attachments/assets/c8f1229b-3415-4759-9019-cf736128dc20" />


---

# Step 9: Run Terraform Apply Again

Now run:

    terraform apply

Enter:

    yes

Terraform will detect the new S3 object configuration and upload the local file to the S3 bucket.

<img width="512" height="202" alt="image" src="https://github.com/user-attachments/assets/cf42989b-fbb2-4c20-9266-d7fed47bcf34" />


---

# Step 10: Check the S3 Bucket

Go to the AWS S3 console.

Open the bucket created by Terraform.

You should now see:

    mydata.txt

<img width="512" height="129" alt="image" src="https://github.com/user-attachments/assets/7e355d17-be6e-4d1a-9d09-b85ad224b29c" />


The file was uploaded from our local computer to the S3 bucket using Terraform.

---

# Step 11: Download and Check the File

Download:

    mydata.txt

<img width="476" height="189" alt="image" src="https://github.com/user-attachments/assets/8898cf33-844c-49a6-ade7-ab2d6e8c4068" />


from the S3 bucket.

Open the downloaded file and verify that it contains the same text:

    Hello everyone, this is only for practice and hands-on experience in creating an S3 bucket with Terraform.

<img width="512" height="183" alt="image" src="https://github.com/user-attachments/assets/1f60926b-ef2d-4155-921a-ff05aba76c61" />


This confirms that Terraform successfully uploaded the local file to AWS S3.

---

# Step 12: Destroy the S3 Bucket

After completing the practice, we can remove the resources created by Terraform.

Run:

    terraform destroy

Terraform will show the resources that will be deleted.

Enter:

    yes

Terraform will destroy the resources created by Terraform.

You should see a message similar to:

    Destroy complete!

<img width="512" height="197" alt="image" src="https://github.com/user-attachments/assets/f10bfdad-dede-4637-8319-449c05619da5" />


---

# Terraform Workflow

    Create Terraform configuration
            ↓
    terraform init
            ↓
    terraform apply
            ↓
    Create S3 bucket
            ↓
    Create vinaysunharetf.txt
            ↓
    terraform apply
            ↓
    Upload mydata.txt to S3
            ↓
    Check file in AWS S3
            ↓
    Download and verify the file
            ↓
    terraform destroy
            ↓
    Delete Terraform resources

---

# Important Terraform Commands

## Initialize Terraform

    terraform init

## Validate Terraform Configuration

    terraform validate

## Preview Changes

    terraform plan

## Create Resources

    terraform apply

## Destroy Resources

    terraform destroy

---

# Final Result

Using Terraform, we successfully:

1. Configured the AWS provider.
2. Configured the Random provider.
3. Generated a random ID.
4. Created a unique S3 bucket.
5. Created a local text file.
6. Uploaded the text file to the S3 bucket.
7. Verified the file in AWS S3.
8. Downloaded and checked the file.
9. Destroyed the Terraform-created resources.

> **Note:** This is only practice and hands-on experience for creating an S3 bucket and uploading an object using Terraform.
