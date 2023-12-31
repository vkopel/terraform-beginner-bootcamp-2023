# Terraform Beginner Bootcamp 2023 - Week 0

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Consideration for Linux Distribution](#consideration-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle](#gitpod-lifecycle)
- [Working Env Vars](#working-env-vars)
  * [env command](#env-command)
  * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
  * [Printing Env Vars](#printing-env-vars)
  * [Scoping of Env Vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
- [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
  * [Terraform Lock Files](#terraform-lock-files)
  * [Terraform State Files](#terraform-state-files)
  * [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format
**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instruction have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Consideration for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to your distribution needs.

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:
```
$ cat /etc/os-release

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

### Refactoring into Bash Scripts

While fixing the terraform CLI gpg depreciation issues, we noticed that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task file ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us an easier time to debug and execute manually Terraform CLI Install.
- This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang Considerations 

A Shebang (Pronounced Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- For different OS distributions
- Will search the user's PATH for the bash executable 

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations 

When executing the bash script, we can use the `./` shorthand notation to execute the bash script.

eg. `./bing/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.
eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations 

In order to make our bash scripts executable, we need to change Linux permissions for the file to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

## Gitpod Lifecycle

We need to be careful when using the Init because it will not rerun if we restart and existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

## Working Env Vars

### env command
We can list out all Environmental Variables (Env Vars) using the `env` command

We can filter specific env vars using grep e.g. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world`

In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command 

```sh
HELLO='world' ./bin/print_message
```
Within a bash script, we can set an env var without export e.g. 

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```
### Printing Env Vars

We can print an env var using echo e.g. `echo $HELLO`

### Scoping of Env Vars

When you open a new bash terminals in VSCode, it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. e.g. `bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage

```sh
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals open in thoes workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation

AWS CLI is install for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful, you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDA5LMGMYACQM7VGS4RK",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM user in order to use the AWS CLI.

## Terraform Basics 

### Terraform Registry 

Terraform sources their providers and modules from the Terraform registry which is located at registry [terraform.io](https://registry.terraform.io/)

- Providers is an interface to APIs that will allow you to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

## Terraform Console 

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project, we will run `terraform init` to download the binaries for the terraform providers that we will use in this project. 

#### Terraform Plan 

`terraform plan`

This will generate out a changeset about the state of our infrastructure and what will be changed.

We can output this changes i.e. "plan" to be passed to an apply, but you can often just ignore outputting.

#### Terraform Apply 

`terraform apply`

This will run  a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply, we can provide the auto approve flag e.g. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`
This will destroy resources.

You can also use the auto approve flag to skip the approve promt e.g. `terraform destroy --auto-approve `

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VCS) e.g. Github

### Terraform State Files

`.terrafor.tfstate` contains information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However, it does not work expected in Gitpod VSCode on the browser.

The workaround is to manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens
```

Then create the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
    "credentials": {
        "app.terraform.io": {
            "toeken": "YOUR_TERRAFORM_CLOUD_TOKEN"
        }
    }
}
```

We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

