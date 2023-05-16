    # Copyright 2023 Google LLC

    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at

    #     https://www.apache.org/licenses/LICENSE-2.0

    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.

locals {
  # IAM Deny profile Policies
  billing_policy            = jsondecode(file("./profiles/billing.json"))
  networking_policy         = jsondecode(file("./profiles/networking.json"))
  dns_policy                = jsondecode(file("./profiles/dns.json"))

  # IAM Deny Exceptions Principals
  networking_exception_principals                = var.networking_exception_principals 
  billing_exception_principals                   = var.billing_exception_principals
  dns_exception_principals                       = var.dns_exception_principals
  iamdeny_tester_exception_principals            = var.iamdeny_tester_exception_principals
}

# One Policy to Deny them all
resource "google_iam_deny_policy" "top_level_deny" {
  provider = google-beta
  parent       = urlencode("${var.iamdeny_folder_path}${var.iamdeny_folder_id}") #TODO update to org ID 
  name         = "top-iam-deny-policy"
  display_name = "Top level Deny Permissions"
  rules {
    description = "One Rule to Deny them All"
    deny_rule {
      denied_principals = ["principalSet://goog/public:all"]
      denial_condition {
        title      = "Match IAM Deny Tag"
        expression = "resource.matchTagId('tagKeys/281480373632495', 'tagValues/281475126570901')" #Tag=iam_deny, value=enabled #TODO: add tags in test org
      }
      denied_permissions = local.project_admin_perms_deny
      exception_principals = local.iamdeny_tester_exception_principals
    }
  }
}

#Profile specific IAM Deny Policy  
resource "google_iam_deny_policy" "profile-deny-policy" {
  provider = google-beta
  parent       = urlencode("${var.iamdeny_folder_path}${var.iamdeny_folder_id}")
  name         = "profile-iam-deny-policy"
  display_name = "Profile Specific IAM Deny Policy"
  rules {
    # One Policy to Find them (DNS),
    description = "One Rule to Find Them"
    deny_rule {
      denied_principals = ["principalSet://goog/public:all"]
      denial_condition {
        title      = "deny all"
        expression = "!resource.matchTag('*/*', '*')"
      }
      denied_permissions   = local.dns_policy.deniedPermissions
      exception_principals = local.dns_exception_principals
    }
  }
  rules {
    # One Policy to Bill them all, 
    description = "One Rule to Bill them all"
    deny_rule {
      denied_principals = ["principalSet://goog/public:all"]
      denial_condition {
        title      = "deny all"
        expression = "!resource.matchTag('*/*', '*')"
      }
      denied_permissions   = local.billing_policy.deniedPermissions
      exception_principals = local.billing_exception_principals
    }
  }
  rules {
    # ..and in their Networks bind them
    description = "And in Their Networks Bind them"
    deny_rule {
      denied_principals = ["principalSet://goog/public:all"] # all users and principals
      denial_condition {
        title = "deny all"
        expression = "!resource.matchTag('*/*', '*')"
      }
      denied_permissions = local.networking_policy.deniedPermissions
      exception_principals = local.networking_exception_principals #except for those we want
    }
  }
}
