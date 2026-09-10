# AWS IAM Access

## AWS User Setup for Terraform

First, log in to your AWS account.

---

## 1. Create an IAM User

Go to:

**AWS Console → IAM → Users → Create user**

Create a new user:

```text
vinay-terraform
```

---

## 2. Set Permissions

Under **Permission options**, select:

**Add user to group**

Click **Create group**.

### Group Name

```text
Vinay-terraform-setup
```

Add the following AWS managed policies to the group:

* [AmazonEC2FullAccess](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonEC2FullAccess)
* [AmazonVPCFullAccess](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonVPCFullAccess)
* [AmazonS3FullAccess](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/policies/details/arn%3Aaws%3Aiam%3A%3Aaws%3Apolicy%2FAmazonS3FullAccess)

> **Note:** Use the minimum permissions required for your Terraform project in a real production environment. `FullAccess` policies are suitable for a learning lab but are broader than necessary.

---

# 3. Create an Access Key

Go to:

**IAM → Users → vinay-terraform → Security credentials**

Under **Access keys**, click:

**Create access key**

Select:

**Command Line Interface (CLI)**

Then confirm the required condition and click:

**Create access key**

You will receive:

### Access Key ID

Example:

```text
ABCDEFGHIJKLMNOPQR
```

### Secret Access Key

Example:

```text
gewgujfsethjsqaeryujkjjjfdsdss
```

> ⚠️ **Security:** Never share your real Access Key ID or Secret Access Key on GitHub, screenshots, WhatsApp, Slack, or anywhere public.

Download the **CSV file** and keep it in a secure location.

---

# AWS CLI Setup for Linux

## 4. Update the Package Repository

Open your Linux terminal and run:

```bash
sudo apt update
```

---

## 5. Install `unzip` and `curl`

```bash
sudo apt install unzip curl
```

---

## 6. Download the AWS CLI Installer

Download the AWS CLI v2 installer:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

---

## 7. Unzip the AWS CLI Installer

```bash
unzip awscliv2.zip
```

---

## 8. Install AWS CLI

```bash
sudo ./aws/install
```

---

## 9. Verify AWS CLI Installation

Run:

```bash
aws --version
```

If the installation was successful, you should see output similar to:

```text
aws-cli/2.x.x Python/3.x.x Linux/x86_64
```

AWS CLI is now installed successfully.

---

# AWS CLI Configuration

## 10. Create a Terraform Learning Folder

Open your VS Code terminal.

Create a new folder:

```bash
mkdir terraform
```

Move into the folder:

```bash
cd terraform
```

You can use an existing `terraform` folder if you have already created one.

---

# 11. Configure AWS Credentials

We have already created an IAM access key for the Terraform user.

For learning purposes, we will use example credentials below.

**Do not use these example credentials. Use your own real AWS credentials.**

### Example Access Key

```text
AKIAIOSFODNN7EXAMPLE
```

### Example Secret Access Key

```text
wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

---

# 12. Create a `.env` File

Inside your Terraform project folder, create a `.env` file:

```bash
vim .env
```

Add the following:

```bash
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2
```

Save and exit the file.

You can also use another AWS region according to your project requirements.

---

# 13. Load the Environment Variables

Run:

```bash
source .env
```

This loads the AWS credentials and region into your current terminal session.

---

# 14. Verify AWS Authentication

Instead of running `aws login`, verify the configured IAM credentials with:

```bash
aws sts get-caller-identity
```

You should receive output similar to:

```json
{
    "UserId": "AIDAXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/vinay-terraform"
}
```

This confirms that AWS CLI is successfully authenticated with your IAM user.

---

# 15. Check IAM Users

You can also test whether your IAM permissions are working:

```bash
aws iam list-users
```

If your IAM user has permission to list users, AWS will return the IAM users in your account.

---

# 16. AWS CLI Environment Variables Documentation

For more information about configuring AWS CLI using environment variables, refer to the official AWS documentation:

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html

---

# Important Security Notes

### Never commit `.env` to GitHub

Add `.env` to your `.gitignore` file:

```bash
echo ".env" >> .gitignore
```

You should also make sure that your AWS credentials are never included in:

* GitHub repositories
* Terraform `.tf` files
* README files
* Screenshots
* Public documentation
* Chat messages
* Docker images
