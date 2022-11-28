Lessons learned during practice:

- https://developer.hashicorp.com/terraform/cli/commands/fmt

- Great read on Github actions and terraform code: https://nedinthecloud.com/2021/12/08/github-actions-with-terraform/

- Information on authenticating via Azure SP from terraform: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

- Defining backend configuration for Azurerm from terraform: https://developer.hashicorp.com/terraform/language/settings/backends/azurerm

- Another great helpful guide, although it is for azure devops, it still related to Github actions: https://julie.io/writing/terraform-on-azure-pipelines-best-practices/

- This guide tells you are you creating github actions secrets: https://gmusumeci.medium.com/deploying-terraform-in-azure-using-github-actions-step-by-step-bf8804b17711


Thurs Nov 24 2022
While troubleshooting I realized that the backend configuration is unable to authenticate 

To solve this problem:

1. I viewed the raw logs from from the settings icon in the Github Actions page.

2. I realized that the following:

----------------the secrets are not being passed-------------------------

2022-11-24T11:15:41.8076004Z shell: /usr/bin/bash --noprofile --norc -e -o pipefail {0}
2022-11-24T11:15:41.8076267Z env:
2022-11-24T11:15:41.8076440Z   TF_LOG: INFO
2022-11-24T11:15:41.8076715Z   TERRAFORM_CLI_PATH: /home/runner/work/_temp/ad24a3e6-f279-45c5-8853-f6dffe7f15e4
2022-11-24T11:15:41.8076982Z   ARM_CLIENT_ID: 
2022-11-24T11:15:41.8077181Z   ARM_CLIENT_SECRET: 
2022-11-24T11:15:41.8077360Z   ARM_TENANT_ID: 
2022-11-24T11:15:41.8077553Z   ARM_SUBSCRIPTION_ID: 
2022-11-24T11:15:41.8077760Z   RESOURCE_GROUP: 
2022-11-24T11:15:41.8077939Z   STORAGE_ACCOUNT: 
2022-11-24T11:15:41.8078160Z   CONTAINER_NAME: 
2022-11-24T11:15:41.8078341Z ##[endgroup]
2022-11-24T11:15:41.9668181Z [command]/home/runner/work/_temp/ad24a3e6-f279-45c5-8853-f6dffe7f15e4/terraform-bin init -backend-config=storage_account_name= -backend-config=container_name= -backend-config=resource_group_name=
2022-11-24T11:15:41.9997024Z 2022-11-24T11:15:41.999Z [INFO]  Terraform version: 1.3.5
2022-11-24T11:15:42.0000761Z 2022-11-24T11:15:41.999Z [INFO]  Go runtime version: go1.19.3
2022-11-24T11:15:42.0002450Z 2022-11-24T11:15:42.000Z [INFO]  CLI args: []string{"/home/runner/work/_temp/ad24a3e6-f279-45c5-8853-f6dffe7f15e4/terraform-bin", "init", "-backend-config=storage_account_name=", "-backend-config=container_name=", "-backend-config=resource_group_name="}
2022-11-24T11:15:42.0009200Z 2022-11-24T11:15:42.000Z [INFO]  CLI command args: []string{"init", "-backend-config=storage_account_name=", "-backend-config=container_name=", "-backend-config=resource_group_name="}
2022-11-24T11:15:42.0028323Z 
2022-11-24T11:15:42.0033365Z [0m[1mInitializing the backend...[0m
2022-11-24T11:15:42.0044762Z 2022-11-24T11:15:42.004Z [INFO]  Testing if Service Principal / Client Certificate is applicable for Authentication..
2022-11-24T11:15:42.0049714Z 2022-11-24T11:15:42.004Z [INFO]  Testing if Multi Tenant Service Principal / Client Secret is applicable for Authentication..
2022-11-24T11:15:42.0054855Z 2022-11-24T11:15:42.005Z [INFO]  Testing if Service Principal / Client Secret is applicable for Authentication..
2022-11-24T11:15:42.0058901Z 2022-11-24T11:15:42.005Z [INFO]  Testing if OIDC is applicable for Authentication..
2022-11-24T11:15:42.0064397Z 2022-11-24T11:15:42.006Z [INFO]  Testing if Managed Service Identity is applicable for Authentication..
2022-11-24T11:15:42.0068207Z 2022-11-24T11:15:42.006Z [INFO]  Testing if Obtaining a Multi-tenant token from the Azure CLI is applicable for Authentication..
2022-11-24T11:15:42.0072389Z 2022-11-24T11:15:42.007Z [INFO]  Testing if Obtaining a token from the Azure CLI is applicable for Authentication..
2022-11-24T11:15:42.0076593Z 2022-11-24T11:15:42.007Z [INFO]  Using Obtaining a token from the Azure CLI for Authentication
2022-11-24T11:15:57.4385486Z [31m[31m╷[0m[0m
2022-11-24T11:15:57.4386645Z [31m│[0m [0m[1m[31mError: [0m[0m[1mError building ARM Config: obtain subscription() from Azure CLI: parsing json result from the Azure CLI: waiting for the Azure CLI: exit status 1: ERROR: Please run 'az login' to setup account.[0m

----------------------------------------------------------------------------------------------------------------------------------------

3. I went ahead to ensure that the secrets were added as "Action secrets" not "Codepsaces secrets" and push my commits again to initialize terraform:

--------------Now the secrets are being passed correctly and initialization is succesful-----------------

2022-11-24T11:33:56.1251390Z shell: /usr/bin/bash --noprofile --norc -e -o pipefail {0}
2022-11-24T11:33:56.1251800Z env:
2022-11-24T11:33:56.1252017Z   TF_LOG: INFO
2022-11-24T11:33:56.1252353Z   TERRAFORM_CLI_PATH: /home/runner/work/_temp/67fb6612-15cd-4d47-847a-9264348f2a1a
2022-11-24T11:33:56.1252901Z   ARM_CLIENT_ID: ***
2022-11-24T11:33:56.1253255Z   ARM_CLIENT_SECRET: ***
2022-11-24T11:33:56.1253607Z   ARM_TENANT_ID: ***
2022-11-24T11:33:56.1253925Z   ARM_SUBSCRIPTION_ID: ***
2022-11-24T11:33:56.1254258Z   RESOURCE_GROUP: ***
2022-11-24T11:33:56.1254573Z   STORAGE_ACCOUNT: ***
2022-11-24T11:33:56.1254888Z   CONTAINER_NAME: ***
2022-11-24T11:33:56.1255133Z ##[endgroup]
2022-11-24T11:33:56.3410706Z [command]/home/runner/work/_temp/67fb6612-15cd-4d47-847a-9264348f2a1a/terraform-bin init -backend-config=storage_account_name=*** -backend-config=container_name=*** -backend-config=resource_group_name=***
2022-11-24T11:33:56.3698325Z 2022-11-24T11:33:56.369Z [INFO]  Terraform version: 1.3.5
2022-11-24T11:33:56.3700619Z 2022-11-24T11:33:56.369Z [INFO]  Go runtime version: go1.19.3
2022-11-24T11:33:56.3702191Z 2022-11-24T11:33:56.369Z [INFO]  CLI args: []string{"/home/runner/work/_temp/67fb6612-15cd-4d47-847a-9264348f2a1a/terraform-bin", "init", "-backend-config=storage_account_name=***", "-backend-config=container_name=***", "-backend-config=resource_group_name=***"}
2022-11-24T11:33:56.3731614Z 2022-11-24T11:33:56.370Z [INFO]  CLI command args: []string{"init", "-backend-config=storage_account_name=***", "-backend-config=container_name=***", "-backend-config=resource_group_name=***"}
2022-11-24T11:33:56.3732382Z 
2022-11-24T11:33:56.3733064Z [0m[1mInitializing the backend...[0m
2022-11-24T11:33:56.3733666Z 2022-11-24T11:33:56.372Z [INFO]  Testing if Service Principal / Client Certificate is applicable for Authentication..
2022-11-24T11:33:56.3734423Z 2022-11-24T11:33:56.372Z [INFO]  Testing if Multi Tenant Service Principal / Client Secret is applicable for Authentication..
2022-11-24T11:33:56.3735167Z 2022-11-24T11:33:56.372Z [INFO]  Testing if Service Principal / Client Secret is applicable for Authentication..
2022-11-24T11:33:56.3735859Z 2022-11-24T11:33:56.372Z [INFO]  Using Service Principal / Client Secret for Authentication
2022-11-24T11:33:56.3736713Z 2022-11-24T11:33:56.372Z [INFO]  Getting OAuth config for endpoint https://login.microsoftonline.com/ with  tenant ***
2022-11-24T11:33:57.2771350Z [0m[32m
2022-11-24T11:33:57.2772121Z Successfully configured the backend "azurerm"! Terraform will automatically
2022-11-24T11:33:57.2772830Z use this backend unless the backend configuration changes.[0m
2022-11-24T11:33:58.2629856Z 
2022-11-24T11:33:58.2630897Z [0m[1mInitializing provider plugins...[0m
2022-11-24T11:33:58.2631519Z - Finding latest version of hashicorp/random...
2022-11-24T11:33:58.2977480Z - Finding hashicorp/azurerm versions matching "3.32.0"...
2022-11-24T11:33:58.3266309Z - Installing hashicorp/random v3.4.3...
2022-11-24T11:33:58.5163046Z - Installed hashicorp/random v3.4.3 (signed by HashiCorp)
2022-11-24T11:33:58.5367739Z - Installing hashicorp/azurerm v3.32.0...
2022-11-24T11:34:00.3189381Z - Installed hashicorp/azurerm v3.32.0 (signed by HashiCorp)
2022-11-24T11:34:00.3189729Z 
2022-11-24T11:34:00.3190097Z Terraform has created a lock file [1m.terraform.lock.hcl[0m to record the provider
2022-11-24T11:34:00.3190639Z selections it made above. Include this file in your version control repository
2022-11-24T11:34:00.3191182Z so that Terraform can guarantee to make the same selections by default when
2022-11-24T11:34:00.3192149Z you run "terraform init" in the future.[0m
2022-11-24T11:34:00.3192384Z 
2022-11-24T11:34:00.3192719Z [0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
2022-11-24T11:34:00.3193141Z [0m[32m
2022-11-24T11:34:00.3193584Z You may now begin working with Terraform. Try running "terraform plan" to see
2022-11-24T11:34:00.3194100Z any changes that are required for your infrastructure. All Terraform commands
2022-11-24T11:34:00.3194504Z should now work.
2022-11-24T11:34:00.3194705Z 
2022-11-24T11:34:00.3194941Z If you ever set or change modules or backend configuration for Terraform,
2022-11-24T11:34:00.3195653Z rerun this command to reinitialize your working directory. If you forget, other
2022-11-24T11:34:00.3196239Z commands will detect it and remind you to do so if necessary.[0m

-----------------------------------------------------------------------------------------------------------



 
