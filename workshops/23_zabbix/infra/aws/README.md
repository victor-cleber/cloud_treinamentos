# aws-zabbix

## Table of Contents
- [What does it do ?](https://github.com/victor-cleber/aws-zabbix#what-does-it-do)
- [This project uses](https://github.com/victor-cleber/aws-zabbix#this-project-uses)
- [Get started](https://github.com/victor-cleber/aws-zabbix#get-started)
- [Clean up](https://github.com/victor-cleber/aws-zabbix#clean-up)
- [Notes](https://github.com/victor-cleber/aws-zabbix#notes)

## What does it do

In this repo you will find Terraform code to create the infrastructure needed to run a [Zabbix](https://zabbix.org/) Server instance. 
The user-data script will download and install the desired Zabbix version and it's dependecies.

At the end of the creation of the VPC and EC2 instance you will be able to access the HTTP interface using the EIP associated with the instance to finish your Zabbix configuration.

## This project uses

- AWS VPC, IGW, EC2, EIP
- Terraform
- Linux Ubuntu
- Zabbix version 7.0
- MySQL server
- Apache server

## Get started

You will need Terraform so if you don't have it yet download from [terraform.io](https://www.terraform.io/downloads.html).

Make changes to the following files

Lines to change:

| Filename | Line | Notes |
| ------------- |:-------------:|:-----|
| user-data.sh | `ZABBIX_PKG_NAME="zabbix-release_7.0+ubuntu22.04_all.deb"` | You can replace with the latest package version if you wish. |
| user-data.sh | `DB_USER="zabbix"` | Replace `zabbix` with your DB username. |
| user-data.sh | `DB_PASS="zabbix"` | Replace `zabbix` with your DB password. |
| user-data.sh | `DB_NAME="zabbix"` | The default is `zabbix`. Replace as appropriate. |


## How to use it

### Run the Terraform code
```bash
terraform init
terraform plan
terraform apply
```

**Result:**
```bash
Apply complete! Resources: 16 added, 0 changed, 0 destroyed.

Outputs:

zabbixserver-eip = 3.12.20.132
```

### Configure your Zabbix server
In your browser, access the IP address that was returned when you created the resources and follow the steps to finish your Zabix Server installation.

Example: `http://3.12.20.132`

## Clean up

- Destroy all the created AWS resources (including the Zabbix server):

```bash
terraform destroy
```

**Result:**
```bash
Destroy complete! Resources: 26 destroyed.
```

## Notes
Running this code will create AWS resources in your account that might not be included in the free tier.
Use this code at your own risk.