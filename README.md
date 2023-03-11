# aws-single-node

This is a custom [Infrastructure As Code (IaC)](https://www.cisco.com/c/en/us/solutions/cloud/what-is-iac.html) solution, written in [Hashicorp Configuration Language (HCL)](https://www.terraform.io/docs/language/index.html). It facilitates the deployment of a single [Elastic Compute Cloud (EC2)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html) instance on Amazon Web Services (AWS). The solution includes a pool of EC2 instances under the Variable Component which can be tailored to meet specific requirements.

## Why Terraform?

[Terraform](https://developer.hashicorp.com/terraform/intro) enables you to safely and predictably create, change and improve infrastructures. This allows a blueprint of your datacenter to be versioned and treated as you would any other code. Additionally, infrastuctures can be shared
and re-used. 

## Prerequisites

To deploy this infrastructure you will need:
* [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) (0.14.9+) installed.
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (2.10.4+) installed.
* [AWS account](https://aws.amazon.com/free/).
* [AWS Access Key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html). It is possible to [generate a new AWS Access Key](https://console.aws.amazon.com/iam/home?#/security_credentials) if desired.

## Installation

1. Clone the solution repository to your local device:
```bash
git clone https://github.com/etoromol/aws-single-node.git
cd aws-single-node
```
2. Initialize the working directory with Terraform:
```bash
terraform init
```

## Configuration

3. Authenticate your AWS account in AWS CLI using your terminal. You will be prompted to enter your AWS Access Key ID and Secret Access Key.
```bash
aws configure
```
*The configuration process stores your credentials in a file at ~/.aws/credentials on MacOS and Linux, or %UserProfile%\.aws\credentials on Windows.*

4. Navigate to the Variable Component ([variable.tf](variables.tf)) and customize the solution's details according to your requirements (description, tag, access_key etc.).
```hcl
variable "project" {
  description = "Cloud VM Infrastructure as Code" <-
  type        = map(string)
  default = {
    tag        = "cloud"                          <-
    access_key = "ssh-cloud-key"                  <-
  }
}
```  

## Deployment

5. Initiate the deployment process:
```bash
terraform apply
```
*It is recommended that you review the deployment plan before with "terraform plan".*

6. Once your EC2 instance is ready, you may access it using your SSH key:
```bash
ssh -i "path/to-your/ssh_key" ec2-user@instance_public_ip
```
*You can obtain the value of instance_public_ip running "terraform output"*

7. If the infrastructure is no longer required, it should be destroyed.:

```bash
terraform destroy
```
*Terraform will present the deployment and destruction plans before and after initialization. Proceed with the destruction/deployment by typing 'yes'; otherwise, Terraform will not proceed any further.*

## License

Copyright (c) 2023 Eduardo Toro.

Licensed under the [MIT](LICENSE) license.