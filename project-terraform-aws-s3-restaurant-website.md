# Terraform AWS S3 Restaurant Website

## Project Name

**terraform-aws-s3-restaurant-website**

We will use Terraform to create an AWS S3 bucket and upload our static website files to the S3 bucket.

Everything will be managed using Terraform instead of manually creating or uploading files from the AWS Console.

The project contains:

- HTML files
- CSS file
- AWS S3 bucket
- S3 public access configuration
- S3 bucket policy
- Terraform-managed file uploads
- Terraform destroy for complete cleanup

---

## Project Folder

Create a new folder:

```text
restaurant-website
```

Inside the folder, create the following files:

```text
restaurant-website/
│
├── s3-restaurant-website.tf
├── index_html
├── index2_html
└── styles_css
```

> In this practice project, we are using `index_html`, `index2_html`, and `styles_css` instead of `.html` and `.css` filenames.

---

# 1. Create First HTML File

Create a file:

```text
index_html
```

Add the following code:

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles_css">
</head>

<body>

    <header>
        <br>
        <h1 id="top">Sunhare Online Food Shop</h1>
    </header>

    <br>
    <hr>

    <nav id="navbar">
        <ul id="navcontent">
            <li><a href="#">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Menu</a></li>
            <li><a href="contact.html">Contact Us</a></li>
        </ul>
    </nav>

    <div id="container1">
        <div id="row1">
        </div>
    </div>

    <hr>
    <br>

    <h1 id="top3">Featured Products</h1>

    <div id="container4">

        <div id="row4">
            <button class="btn">ORDER NOW</button>
        </div>

        <div id="row5">
            <button class="btn">ORDER NOW</button>
        </div>

        <div id="row6">
            <button class="btn">ORDER NOW</button>
        </div>

    </div>

    <footer>
        Copyright © 2026 Sunhare Online Food Shop.
        All Rights are reserved
    </footer>

</body>

</html>
```

---

# 2. Create Second HTML File

Create:

```text
index2_html
```

Add:

```html
<!-- Filename - contact.html -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles_css">
    <title>Contact Us</title>
</head>

<body>

    <div id="ContactUs">

        <h1>Contact Us</h1>

        <form action="#">

            <div class="form-shape">
                <label for="query">Type of Query</label>

                <select name="myQuery" id="query">
                    <option value="sel" selected>Select</option>
                    <option value="ord">Order related Issues</option>
                    <option value="Site">Site related Issues</option>
                    <option value="fed">Complaint related Issues</option>
                    <option value="others">Others</option>
                </select>
            </div>

            <div class="form-shape">
                <label for="name">Name</label>
                <input
                    type="text"
                    name="myName"
                    id="name"
                    placeholder="Enter your Name"
                >
            </div>

            <div class="form-shape">
                <label for="email">Email-Id</label>
                <input
                    type="email"
                    name="myEmail"
                    id="email"
                    placeholder="Enter your email"
                >
            </div>

            <div class="form-shape">
                <label for="pho">Phone Number</label>
                <input
                    type="phone"
                    name="myPhone"
                    id="pho"
                    placeholder="Enter your Phone no"
                >
            </div>

            <div id="radio">
                Are you a member of OnlineFoodShop:

                Yes <input type="radio" name="eligible" value="yes">
                No <input type="radio" name="eligible" value="no">
            </div>

            <div class="form-shape">
                <label for="message">Elaborate your query</label>

                <textarea
                    name="mesg"
                    id="message"
                    cols="30"
                    rows="10"
                ></textarea>
            </div>

            <input type="submit" value="Submit">
            <input type="reset" value="Reset">

        </form>

    </div>

    <footer>
        Copyright © 2026 Sunhare Online Food Shop.
        All Rights are reserved
    </footer>

</body>

</html>
```

---

# 3. Create CSS File

Create:

```text
styles_css
```

Add:

```css
/* style_css */

/* CSS Reset */
* {
    margin: 0;
    padding: 0;
}

/* Header Styling */
#top {
    color: rgb(8, 65, 173);
    text-align: center;
    font-size: 50px;
    font-family: 'Ubuntu Mono', monospace;
}

#top1 {
    text-align: center;
    color: black;
    font-weight: bold;
    font-size: 25px;
    font-family: 'Ubuntu Mono', monospace;
}

/* Navbar Image Styling */
#navbar img {
    display: block;
    width: 50px;
    height: 50px;
    margin: auto;
    margin-bottom: 5px;
}

/* Navbar Functionality */
#navbar {
    display: flex;
    flex-direction: column;
    background-color: rgb(255, 255, 255);
    height: 14vh;
    width: 100vw;
    font-family: 'Ubuntu Mono', monospace;
    margin-top: 10px;
    border: 2px solid black;
    border-radius: 15px;
}

/* Navbar Content Functionality */
#navcontent {
    display: flex;
    justify-content: center;
}

/* Navbar Content Styling */
ul li {
    list-style: none;
    margin: 35px;
    border-radius: 30px;
}

ul li a {
    padding: 10px;
    color: rgb(0, 0, 0);
    text-decoration: none;
    border-radius: 10px;
}

ul li a:hover {
    background-color: rgb(0, 0, 0);
    color: white;
    border-radius: 20px;
}

/* Website Background Image */
#container1 {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100vw;
    height: 63vh;
}

/* Background Image */
#container1::before {
    content: '';
    background: url("https://img.freepik.com/free-vector/food-delivery-landing-page-template_23-2148566369.jpg")
        no-repeat center center / cover;
    width: 100vw;
    height: 50vh;
    position: absolute;
    top: 0;
    left: 0;
    font-family: 'Ubuntu Mono', monospace;
    margin-right: 45px;
    font-weight: bold;
    z-index: -1;
    opacity: 0.89;
    border: 2px solid black;
    border-bottom-left-radius: 100px;
}

/* Row 1 Styling */
#row1 {
    color: rgb(255, 255, 255);
    font-weight: bold;
    font-size: 2rem;
    text-align: center;
    margin-top: 35px;
}

/* Button Styling */
.btn {
    margin-top: 20px;
    border: 3px solid rgb(0, 0, 0);
    border-radius: 15px;
    background-color: rgb(255, 255, 255);
    font-size: 20px;
    font-weight: bold;
    font-family: 'Ubuntu', sans-serif;
}

.btn:hover {
    cursor: pointer;
    background-color: rgb(255, 255, 255);
}

/* Container 3 */
#container3 {
    display: flex;
    justify-content: space-evenly;
}

/* Row 2 */
#row2 {
    width: 24vw;
    height: 21vh;
    box-shadow: 2px 7px 16px 19px;
    margin-top: 51px;
    margin-bottom: 51px;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    position: relative;
    margin-right: 38px;
    border-radius: 40px;
}

#row2::before {
    content: '';
    background: url("https://media.geeksforgeeks.org/wp-content/uploads/20240711123257/jpeg-optimizer_2151336570.jpg")
        no-repeat center center / cover;
    position: absolute;
    top: 0;
    left: 0;
    width: 24vw;
    height: 21vh;
    z-index: -1;
    border-radius: 40px;
}

/* Row 3 */
#row3 {
    position: relative;
    width: 24vw;
    height: 21vh;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    box-shadow: 2px 7px 16px 19px;
    margin-top: 51px;
    margin-bottom: 51px;
    margin-left: 38px;
    border-radius: 40px;
}

#row3::before {
    content: '';
    background: url("https://media.geeksforgeeks.org/wp-content/uploads/20240711123256/jpeg-optimizer_6656747_21351.jpg")
        no-repeat center center / cover;
    position: absolute;
    top: 0;
    left: 0;
    width: 24vw;
    height: 21vh;
    z-index: -1;
    border-radius: 40px;
}

/* Top 3 */
#top3 {
    text-align: center;
    color: rgb(8, 65, 173);
    font-family: 'Ubuntu Mono', monospace;
}

/* Container 4 */
#container4 {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    margin: 41px;
}

/* Row 4 */
#row4 {
    width: 29vw;
    height: 360px;
    border: 2px solid black;
    background: url("https://media.geeksforgeeks.org/wp-content/uploads/20240711123258/jpeg-optimizer_various-meals-western-food-platter-dark-background.jpg")
        no-repeat center center / cover;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    border-radius: 15px;
}

/* Row 5 */
#row5 {
    width: 29vw;
    height: 360px;
    border: 2px solid black;
    background: url("https://media.geeksforgeeks.org/wp-content/uploads/20240711123257/jpeg-optimizer_2151182491.jpg")
        no-repeat center center / cover;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    border-radius: 15px;
}

/* Row 6 */
#row6 {
    width: 30vw;
    height: 360px;
    border: 2px solid black;
    background: url("https://media.geeksforgeeks.org/wp-content/uploads/20240711123255/jpeg-optimizer_4744.jpg")
        no-repeat center center / cover;
    display: flex;
    justify-content: center;
    align-items: flex-end;
    border-radius: 15px;
}

/* Footer */
footer {
    text-align: center;
}

/* Contact Us */
#ContactUs {
    width: 100vw;
    height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: rgb(248, 213, 181);
}

.form-shape input,
.form-shape select,
.form-shape textarea {
    width: 92%;
    padding: 0.5rem;
}

/* Placeholder */
::placeholder {
    color: gray;
}

/* Responsive Design */

@media only screen and (max-width: 1131px) {

    #row4 {
        width: 42vw;
    }

    #row5 {
        width: 45vw;
    }

    #row6 {
        margin-top: 20px;
        width: 90vw;
    }
}

@media only screen and (min-width: 600px) and (max-width: 781px) {

    #row4 {
        width: 84vw;
        margin: auto;
        margin-left: 22px;
    }

    #row5 {
        width: 84vw;
        margin: auto;
        margin-top: 20px;
        margin-left: 22px;
    }

    #row6 {
        width: 84vw;
        margin: auto;
        margin-top: 20px;
        margin-left: 22px;
    }
}

@media only screen and (max-width: 600px) {

    #row4 {
        width: 78vw;
        margin: auto;
        margin-left: 3px;
    }

    #row5 {
        width: 78vw;
        margin: auto;
        margin-top: 20px;
        margin-left: 3px;
    }

    #row6 {
        width: 78vw;
        margin: auto;
        margin-top: 20px;
        margin-left: 3px;
    }
}

@media only screen and (min-height: 600px) {

    #navbar {
        height: 10vh;
    }

    #container1::before {
        height: 39vh;
    }

    #container1 {
        height: 44vh;
    }
}
```

---

# 4. Create S3 Bucket Using Terraform

We will create an S3 bucket using Terraform.

```hcl
resource "aws_s3_bucket" "foodshop_bucket" {
    bucket = "foodshop-bucket-${random_id.random_id.hex}"
}
```

The `random_id` resource generates a random value so that the S3 bucket name is unique.

---

# 5. Upload First HTML File to S3

```hcl
resource "aws_s3_object" "index_html" {
    bucket       = aws_s3_bucket.foodshop_bucket.bucket
    source       = "./index_html"
    key          = "index_html"
    content_type = "text/html"
}
```

---

# 6. Upload Second HTML File to S3

```hcl
resource "aws_s3_object" "index2_html" {
    bucket       = aws_s3_bucket.foodshop_bucket.bucket
    source       = "./index2_html"
    key          = "index2_html"
    content_type = "text/html"
}
```

---

# 7. Upload CSS File to S3

```hcl
resource "aws_s3_object" "styles_css" {
    bucket       = aws_s3_bucket.foodshop_bucket.bucket
    source       = "./styles_css"
    key          = "styles_css"
    content_type = "text/css"
}
```

---

# 8. Configure S3 Public Access

Go to the Terraform AWS provider documentation:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block

We will use:

```hcl
resource "aws_s3_bucket_public_access_block" "example" {

    bucket = aws_s3_bucket.foodshop_bucket.bucket

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}
```

By default, S3 blocks public access.

For this practice project, we are setting these values to `false` because we will use a public-read bucket policy.

---

# 9. Add S3 Bucket Policy

Go to:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

We will create a bucket policy that allows public read access to objects inside our bucket.

```hcl
resource "aws_s3_bucket_policy" "foodshop_bucket" {

    bucket = aws_s3_bucket.foodshop_bucket.id

    policy = jsonencode({

        Version = "2012-10-17"

        Statement = [

            {
                Sid       = "PublicReadGetObject"
                Effect    = "Allow"
                Principal = "*"

                Action = [
                    "s3:GetObject"
                ]

                Resource = "arn:aws:s3:::${aws_s3_bucket.foodshop_bucket.id}/*"
            }

        ]
    })
}
```

This policy allows:

```text
s3:GetObject
```

for objects inside the bucket.

---

# 10. AWS S3 Website Access Documentation

AWS documentation:

https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html

This documentation explains the permissions required for S3 website access.

---

# 11. Create Terraform File

Create a new file:

```text
s3-restaurant-website.tf
```

Add the complete Terraform configuration:

```hcl
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

    region = "us-east-1"
}

resource "random_id" "random_id" {

    byte_length = 10
}

resource "aws_s3_bucket" "foodshop_bucket" {

    bucket = "foodshop-bucket-${random_id.random_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "example" {

    bucket = aws_s3_bucket.foodshop_bucket.bucket

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "foodshop_bucket" {

    bucket = aws_s3_bucket.foodshop_bucket.id

    policy = jsonencode({

        Version = "2012-10-17"

        Statement = [

            {
                Sid       = "PublicReadGetObject"
                Effect    = "Allow"
                Principal = "*"

                Action = [
                    "s3:GetObject"
                ]

                Resource = "arn:aws:s3:::${aws_s3_bucket.foodshop_bucket.id}/*"
            }

        ]
    })
}

resource "aws_s3_object" "index_html" {

    bucket       = aws_s3_bucket.foodshop_bucket.bucket
    source       = "./index_html"
    key          = "index_html"
    content_type = "text/html"
}

resource "aws_s3_object" "index2_html" {

    bucket       = aws_s3_bucket.foodshop_bucket.bucket
    source       = "./index2_html"
    key          = "index2_html"
    content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {

    bucket       = aws_s3_bucket.foodshop_bucket.bucket
    source       = "./styles_css"
    key          = "styles_css"
    content_type = "text/css"
}

output "name" {

    value = random_id.random_id.hex
}
```

Save the file.

---

# 12. Terraform Init

Open the terminal inside the project folder:

```bash
cd restaurant-website
```

Run:

```bash
terraform init
```
<img width="512" height="248" alt="image" src="https://github.com/user-attachments/assets/57af2e66-3e77-4639-acf5-3246d5c325c6" />


Terraform will initialize the required providers.

---

# 13. Terraform Plan

Run:

```bash
terraform plan
```
<img width="512" height="348" alt="image" src="https://github.com/user-attachments/assets/757bc7ae-6c5c-42e8-9ddc-80941f160668" />

Terraform will show the resources that it plans to create.

Expected resources:

```text
random_id
aws_s3_bucket
aws_s3_bucket_public_access_block
aws_s3_bucket_policy
aws_s3_object.index_html
aws_s3_object.index2_html
aws_s3_object.styles_css
```

---

# 14. Terraform Apply

Run:

```bash
terraform apply
```

Terraform will ask for confirmation.

Enter:

```text
yes
```
<img width="512" height="342" alt="image" src="https://github.com/user-attachments/assets/9d3fb4d1-b25d-4bd7-bb89-22b9772c6962" />
<img width="512" height="280" alt="image" src="https://github.com/user-attachments/assets/4a9240be-3e41-4a5c-bb92-4ec6beb04215" />


Terraform will then create:

```text
S3 Bucket
S3 Public Access Configuration
S3 Bucket Policy
index_html
index2_html
styles_css
```

---

# 15. Check AWS S3 Bucket

Go to:

```text
AWS Console
→ S3
```

Our bucket should be visible.

The bucket name will look similar to:

```text
foodshop-bucket-39ba5104a2a1502e3afa
```
<img width="512" height="130" alt="image" src="https://github.com/user-attachments/assets/17eca074-49bd-481c-91b5-9e728012ba9b" />

The random part will be different for each deployment.

Open the bucket.

You should see:

```text
index_html
index2_html
styles_css
```
<img width="512" height="151" alt="image" src="https://github.com/user-attachments/assets/4eb60569-7d1a-4c8a-8c47-77a454bea9a0" />

So our three files have been uploaded to S3 using Terraform.

---

# 16. Open index_html

Click:

```text
index_html
```
<img width="512" height="237" alt="image" src="https://github.com/user-attachments/assets/202b0bc7-0401-4683-88d3-7a2e248984c9" />

The object URL will look similar to:

```text
https://foodshop-bucket-39ba5104a2a1502e3afa.s3.us-east-1.amazonaws.com/index_html
```
<img width="512" height="312" alt="image" src="https://github.com/user-attachments/assets/304d87c2-d41a-4b15-a44d-def27a40b007" />

The actual bucket name will be different in your AWS account.

---

# 17. Open index2_html

Open:

```text
index2_html
```
<img width="512" height="249" alt="image" src="https://github.com/user-attachments/assets/36a11574-8039-4437-a1d7-9bfe9d4899e3" />

Its object URL will look similar to:

```text
https://foodshop-bucket-39ba5104a2a1502e3afa.s3.us-east-1.amazonaws.com/index2_html
```
<img width="512" height="267" alt="image" src="https://github.com/user-attachments/assets/9187aa41-2d06-478c-aada-f597735de629" />

---

# 18. Terraform Destroy

After testing the project, we don't want to keep our practice files and S3 bucket in AWS.

We can remove everything using Terraform.

Run:

```bash
terraform destroy
```
<img width="512" height="267" alt="image" src="https://github.com/user-attachments/assets/36034365-7fd8-4ac2-888e-001d52c3d3f8" />

Terraform will show the resources that will be destroyed.

Enter:

```text
yes
```

Terraform will remove the resources created by this configuration.

This includes:

```text
S3 Bucket
S3 Bucket Policy
S3 Public Access Configuration
index_html
index2_html
styles_css
random_id
```

---

# 19. Verify S3 Bucket Removal

Go to:

```text
AWS Console
→ S3
```
<img width="512" height="181" alt="image" src="https://github.com/user-attachments/assets/cbf22a64-8730-45d7-9aef-2c5160597202" />

Check the bucket list.

Our Terraform-created S3 bucket should no longer exist.

This confirms that we successfully removed the infrastructure using:

```bash
terraform destroy
```

---

# Complete Project Workflow

```text
Create Project Folder
        ↓
Create index_html
        ↓
Create index2_html
        ↓
Create styles_css
        ↓
Create s3-restaurant-website.tf
        ↓
terraform init
        ↓
terraform plan
        ↓
terraform apply
        ↓
Terraform Creates S3 Bucket
        ↓
Terraform Uploads HTML + CSS Files
        ↓
Go to AWS S3
        ↓
Check Bucket
        ↓
Check 3 Uploaded Files
        ↓
Open index_html
        ↓
Open index2_html
        ↓
terraform destroy
        ↓
S3 Bucket Removed
```

---

# Final Project Structure

```text
restaurant-website/
│
├── s3-restaurant-website.tf
├── index_html
├── index2_html
└── styles_css
```

---

# What We Learned

Through this project, we practiced:

- Terraform
- AWS Provider
- Random Provider
- AWS S3
- S3 Bucket
- S3 Objects
- S3 Public Access Block
- S3 Bucket Policy
- `terraform init`
- `terraform plan`
- `terraform apply`
- `terraform destroy`
- Infrastructure as Code
- Uploading website files using Terraform
- Managing AWS infrastructure without manually creating resources from the AWS Console

---

# Important Note

This project uses a public-read S3 bucket policy for learning and practice.

The following policy:

```text
s3:GetObject
```

allows public access to objects in the bucket.

Do not use public-read S3 configuration for sensitive or private files.

For a production static website, a more complete architecture can be:

```text
Route 53
    ↓
CloudFront
    ↓
S3
```

This project intentionally keeps the architecture simple so that we can practice Terraform and AWS S3 fundamentals.
