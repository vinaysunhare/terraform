
# Install Terraform on Debian / Ubuntu

# 1. Update system package lists

```bash
sudo apt-get update
```

# 2. Fix interrupted package errors (if prompted)
```bash
sudo dpkg --configure -a
```
# 3. Install required packages
```bash
sudo apt-get install -y software-properties-common curl gnupg
```
# 4. Add HashiCorp GPG key
```bash
curl -fsSL [https://apt.releases.hashicorp.com/gpg](https://apt.releases.hashicorp.com/gpg) | sudo tee /etc/apt/trusted.gpg.d/hashicorp.asc
```
# 5. Add HashiCorp official repository
```bash
sudo apt-add-repository "deb [arch=amd64] [https://apt.releases.hashicorp.com](https://apt.releases.hashicorp.com) $(lsb_release -cs) main"
```
# 6. Update package index and install Terraform
```bash
sudo apt-get update && sudo apt-get install -y terraform
```
# 7. Verify the installation
```bash
terraform -v
```
