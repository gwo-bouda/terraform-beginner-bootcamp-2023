# Terraform Beginner Bootcamp 2023

## Semantic versioning :mage:
[semver.otg](https://semver.org/)

Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR version** when you make incompatible API changes
- **MINOR version** when you add functionality in a backward compatible manner
- **PATCH version** when you make backward compatible bug fixes

### **INSTALL THE TERRAFORM CLI FOR LINUX**
[TERRA CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### **GITPOD CONFIGURE WORKSPACES**
[GITPOD WORKSPACE CONF](https://www.gitpod.io/docs/configure/workspaces)
[TASKS](https://www.gitpod.io/docs/configure/workspaces/tasks)

### **CHMOD**
[CHMOD](https://en.wikipedia.org/wiki/Chmod)

### **Consideration for linux disto**
This project is built againt ubuntu. Consider checking your linux distro.
[How to check linux distro](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

```
cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## Refactoring bash scripts
An error was display concerning deprecated gpg key we notice that bash scripts steps were quite different than the initial install bash scirpt. We refreshed the terraform install script.
- Tidy GITPOD ([.gitpod.yml](.gitpod.yml))
- Easier debug and prevent manual installation of terraform cli
- better portability 
- this bash script is located -> [./bin/install_terraform_cli](./bin/install_terraform_cli)

### AWS CLI INSTALLATION

AWS CLI is installed for this project via the bash script /bin/install_aws_cli
[install aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

### AWS CLI ENV VARS
[aws cli env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
```
$ export AWS_ACCESS_KEY_ID=''
$ export AWS_SECRET_ACCESS_KEY=''
$ export AWS_DEFAULT_REGION='ca-central-1'
```
we can check if we're log into aws tenant with -> 
```sh
aws sts get-caller-identity
```

if successful a json payload is shown
```json
{
"userId":
"Account":
"Arn":
 }
 ```

 ## Terraform basic

 ### Terraform registry
 Terraform sources their providers and module are located at [registry.terrafor.io](https://registry.terraform.io/)
 - **Provider** is an interface to APIS that allow to create ressource in terraform
 - **Modules** are templates to terraform code /share/modular/portable

 ### Terraform console
  - All terraform commands are seen by typing ```Terraform ```

 ### Terraform Amazon Provider create S3 bucket
 -> [S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
 **N.B** add an error in main.tf indicating that "tags" was not recognized.
 ```JSON
 resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```

### Issues with terraform cloud login and gitpod
We must create the file manually -> touch /home/gitpod/.terraform.d/credentials.tfrc.json
and insert this code ->
```json
 "credentials": {
    "app.terraform.io": {
      "token": "key"
    }
  }
}
```

