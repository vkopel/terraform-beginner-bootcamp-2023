# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
- PROJECT_ROOT
  - main.tf - Everything else.
  - variables.tf - Stores the structure of input variables.
  - terraform.tfvars - The data variables we want to load into our terraform project.
  - providers.tf - Defines required providers and their configuration.
  - outputs.tf - Stores our outputs.
  - README.md - Required for the root modules.
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform  and Input Variables
### Terraform Cloud Variables

In terraform, we can set two kind of variables:
- Environment Variables - Those that you would set in your bash terminal e.g. AWS credentials
- Terraform Variables - Those that you would normally set in your tfvars file

We can set Terraform Cloud Variables to be sentitive so they are not shown visibly in the UI

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file e.g. `terraform -var user_uuid="my-user_id"`

### var-file flag

 - TODO: Document this flag.

### terraform.tfvars

This is the default file to load in terraform variables in blunk.

### auto.tfvars

 - TODO: Document this functionality for terraform cloud. 

 ### order of terraform variables

  - TODO: Document which terraform variables takes presendence.