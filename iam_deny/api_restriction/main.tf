# This list constraint defines the allowed APIs for the folder or project specified
module "restrictResourceUsageApis" {
  source      = "terraform-google-modules/org-policy/google" #TODO: v2 of this is out and syntax is different than this, will need to update
  version     = "~> 5.1.0"
  constraint  = "constraints/gcp.restrictServiceUsage"
  policy_type = "list"
  deny = [
    "managedidentities.googleapis.com",
    ]
  deny_list_length = 1
  policy_for        = "folder"
  folder_id         = var.folder_id
}