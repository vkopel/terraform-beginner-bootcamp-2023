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
