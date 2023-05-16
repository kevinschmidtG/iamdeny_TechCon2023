# iamdeny_TechCon2023
IAM Deny example repo shown at TechCon 2023


## Overview 
Demo repo shared with [accompanying slides](https://docs.google.com/presentation/d/1v2xs-KBZL1M6tEait86ICbt6o2MmR1bFK_-Sn1hgDcc/edit?usp=sharing&resourcekey=0-YrZzQaQqLEPcmdcoDaesug) for **IAM Deny at Enterprise Scale** at [TechCon 2023](https://www.techcon23.io/). 

Feel free to reach out to kevinaschmidt@google.com for any relevant questions, commments, concerns, derogatory remarks (keep it googley), update suggestions, etc. 

## Pre-requisites 

1. Enable the IAM API in your project
2. In your project, make sure you are at least [Deny Admin](https://cloud.google.com/iam/docs/understanding-roles#iam.denyAdmin) 
3. Make sure you are logged into that account when running the gcloud commands below


## Set up your environment

1. In your terminal, log into GCP

``` shell
gcloud auth login
gcloud auth application-default login

```
2. Move into the terraform folder 

``` shell
cd terraform/ 
```

3. Initialize Terraform 

``` shell
terraform init
```

4. Update your target default folder in the provided **variables.tf** and any relevant exception princpals, regions, etc

``` shell
variable "iamdeny_folder_id" {
  description = "The folder ID to place the policy within."
  type        = string
  default     = "" #Update your default folder ID here
}
```
5. Terraform Plan and Apply

``` shell
terraform plan
```

If you are satisfied with that output run terraform apply to attach the policy to your target attachment point (**iamdeny_folder_id**)

``` shell
terraform plan
```

## Commands for viewing/debugging

At the time of writing this ReadMe, viewing policies in the Cloud Console isn't currenlty supported, but on the roadmap. To interact with, troubleshoot, and see these policies after application via terraform, keep the following gcloud commands handy. You can also check the main [IAM Deny documentation page](https://cloud.google.com/iam/docs/deny-access) for the most up to date commands: 

### List Deny Policies 

**ATTACHMENT_POINT** here is equivalent to what terraform shows as **parent**, which in our case is the folder ID you designate. 

For our example it will follow this sytax: `cloudresourcemanager.googleapis.com/folders/FOLDER_ID` where FOLDER_ID = **iamdeny_folder_id**

Refer to [how to identify the attachment point](https://cloud.google.com/iam/docs/deny-access#attachment-point) for more examples. 

``` shell
gcloud iam policies list \
    --attachment-point=ATTACHMENT_POINT \ 
    --kind=denypolicies \
    --format=json
```

### View Deny Policy

**ATTACHMENT_POINT** here is equivalent to what terraform shows as **parent**, which in our case is the folder ID you designate. 

For our example it will follow this sytax: `cloudresourcemanager.googleapis.com/folders/FOLDER_ID` where FOLDER_ID = **iamdeny_folder_id**

Refer to [how to identify the attachment point](https://cloud.google.com/iam/docs/deny-access#attachment-point) for more examples. 

**POLICY_ID** is equivalent to "name" in the resource object of the policy defined in terraform. It is also the last ID in the path given for "name" when you list the policies above. 

For example, when you call `gcloud iam policies list` above and get the following, 

```JSON
    {
      "createTime": "2023-05-12T23:32:50.466255Z",
      "displayName": "Top level Deny Permissions",
      "kind": "DenyPolicy",
      "name": "policies/cloudresourcemanager.googleapis.com%2Ffolders%2F334444035081/denypolicies/top-iam-deny-policy",
      "uid": "8bef4def-dfad-3b43-651f-88e743fe6c02",
      "updateTime": "2023-05-12T23:32:50.466255Z"
    }
```

**POLICY_ID** would be 'top-iam-deny-policy'

```shell
gcloud iam policies get POLICY_ID \
    --attachment-point=ATTACHMENT_POINT \
    --kind=denypolicies \
    --format=json
```

### More Commands 

You can find more commands to interact with [IAM Deny Policies in the Google Cloud Documentation](https://cloud.google.com/iam/docs/deny-access)