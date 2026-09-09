
# Install Terraform on Debian / Ubuntu

```bash
# 1. Update system package lists
sudo apt-get update

# 2. Fix interrupted package errors (if prompted)
sudo dpkg --configure -a

# 3. Install required packages
sudo apt-get install -y software-properties-common curl gnupg

# 4. Add HashiCorp GPG key
curl -fsSL [https://apt.releases.hashicorp.com/gpg](https://apt.releases.hashicorp.com/gpg) | sudo tee /etc/apt/trusted.gpg.d/hashicorp.asc

# 5. Add HashiCorp official repository
sudo apt-add-repository "deb [arch=amd64] [https://apt.releases.hashicorp.com](https://apt.releases.hashicorp.com) $(lsb_release -cs) main"

# 6. Update package index and install Terraform
sudo apt-get update && sudo apt-get install -y terraform

# 7. Verify the installation
terraform -v
