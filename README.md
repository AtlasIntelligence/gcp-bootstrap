# gcp-bootstrap

This project contains the Terraform template needed to build the atlasSource infrastructure and the CI to update/modify it automatically.

## Overview:

the project contains several distinct contents that must be applied separately according to specific order.

### [1 - Makefile](./Makefile)
For a new project, perform a manual step using Makefile that validates the prerequisite and creates and configures the bucket to store the Terraform state remotely.
If the project has already been created and the terraform bucket is already created, then skip the first step and configure your terraform backend with the existing bucket.

- How to use the `Makefile`
  - check the prerequiste
  ```bash
  END_USER_EMAIL=dummy@example.com ORGANIZATION_ID=my_orga_id BILLING_ACCOUNT_ID=my_billing_acc_id make start
  ```
    this command checks if you have the necessary tools for the setup, then it connects to GCP and executes commands to check if the user has the necessary rights to execute the next steps

  - Set up a new stage
  ```bash
  ENV=stage Make prepare
  ```
    this command checks if a bucket already exists for the Terraform remote backend and if it does not exist it creates it

### [2 - Modules](./modules)
This is a set of terraform configuration files, this structure is intended to make it easier to navigate, understand and update your configuration by grouping related parts of our configuration.
each Sub-Directory consists of a resource that we use in our infrastructure, a resource that is a service or a set of services grouped together, such as vpc + subnets + route table.

- overview of the module structure
```
gcp-bootstrap/
└── modules
    ├── cloud-function
    ├── cloud-run
    ├── iam
    ├── project
    └── network-fabric
       ├── dns
       ├── vpc
       ├── subnets
       ├── routes
       ├── firewall-rules
       ├── loadbalancer
       ├── network-peering
       └── private-service-connect
```


# CI
![CICD](./images/Infrastructure-CD-2.png)
