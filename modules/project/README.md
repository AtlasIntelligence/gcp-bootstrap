<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_service.gcp_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing account assign to project | `string` | n/a | yes |
| <a name="input_gcp_service_list"></a> [gcp\_service\_list](#input\_gcp\_service\_list) | The list of apis necessary for the project | `list(string)` | <pre>[<br>  "cloudresourcemanager.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "servicenetworking.googleapis.com",<br>  "cloudkms.googleapis.com",<br>  "logging.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "iam.googleapis.com",<br>  "admin.googleapis.com",<br>  "appengine.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "pubsub.googleapis.com",<br>  "securitycenter.googleapis.com",<br>  "accesscontextmanager.googleapis.com",<br>  "billingbudgets.googleapis.com",<br>  "essentialcontacts.googleapis.com",<br>  "compute.googleapis.com",<br>  "vpcaccess.googleapis.com",<br>  "dns.googleapis.com"<br>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Unique project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
<!-- END_TF_DOCS -->