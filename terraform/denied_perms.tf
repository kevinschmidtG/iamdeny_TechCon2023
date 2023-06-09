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

#Broad list of permissions to deny 
locals {
  project_admin_perms_deny = [
    # client OAuth2 clients
    "clientauthconfig.googleapis.com/brands.create",
    "clientauthconfig.googleapis.com/brands.delete",
    "clientauthconfig.googleapis.com/brands.update",
    "clientauthconfig.googleapis.com/clients.create",
    "clientauthconfig.googleapis.com/clients.createSecret",
    "clientauthconfig.googleapis.com/clients.delete",
    "clientauthconfig.googleapis.com/clients.getWithSecret",
    "clientauthconfig.googleapis.com/clients.listWithSecrets",
    "clientauthconfig.googleapis.com/clients.undelete",
    "clientauthconfig.googleapis.com/clients.update",
    # networking permissions
    "compute.googleapis.com/externalVpnGateways.create",
    "compute.googleapis.com/externalVpnGateways.delete",
    "compute.googleapis.com/externalVpnGateways.setLabels",
    "compute.googleapis.com/externalVpnGateways.use",
    "compute.googleapis.com/interconnectAttachments.create",
    "compute.googleapis.com/interconnectAttachments.delete",
    "compute.googleapis.com/interconnectAttachments.setLabels",
    "compute.googleapis.com/interconnectAttachments.update",
    "compute.googleapis.com/interconnectAttachments.use",
    "compute.googleapis.com/interconnects.create",
    "compute.googleapis.com/interconnects.delete",
    "compute.googleapis.com/interconnects.setLabels",
    "compute.googleapis.com/interconnects.update",
    "compute.googleapis.com/interconnects.use",
    "compute.googleapis.com/networks.addPeering",
    "compute.googleapis.com/networks.create",
    "compute.googleapis.com/networks.delete",
    "compute.googleapis.com/networks.mirror",
    "compute.googleapis.com/networks.removePeering",
    "compute.googleapis.com/networks.switchToCustomMode",
    "compute.googleapis.com/networks.update",
    "compute.googleapis.com/networks.updatePeering",
    "compute.googleapis.com/networks.updatePolicy",
    "compute.googleapis.com/networks.use",
    "compute.googleapis.com/networks.useExternalIp",
    "compute.googleapis.com/publicAdvertisedPrefixes.create", 
    "compute.googleapis.com/publicAdvertisedPrefixes.delete",
    "compute.googleapis.com/publicAdvertisedPrefixes.update",
    "compute.googleapis.com/publicAdvertisedPrefixes.updatePolicy",
    "compute.googleapis.com/publicDelegatedPrefixes.create",
    "compute.googleapis.com/publicDelegatedPrefixes.delete",
    "compute.googleapis.com/publicDelegatedPrefixes.update",
    "compute.googleapis.com/publicDelegatedPrefixes.updatePolicy",
    "compute.googleapis.com/routers.create",
    "compute.googleapis.com/routers.delete",
    "compute.googleapis.com/routers.update",
    "compute.googleapis.com/routers.use",
    "compute.googleapis.com/routes.create",
    "compute.googleapis.com/routes.delete",
    "compute.googleapis.com/subnetworks.create",
    "compute.googleapis.com/subnetworks.delete",
    "compute.googleapis.com/subnetworks.expandIpCidrRange",
    "compute.googleapis.com/subnetworks.getIamPolicy", # not mutable - Works in V2, originally commented out
    "compute.googleapis.com/subnetworks.mirror",
    "compute.googleapis.com/subnetworks.setIamPolicy",
    "compute.googleapis.com/subnetworks.setPrivateIpGoogleAccess",
    "compute.googleapis.com/subnetworks.update",
    "compute.googleapis.com/targetVpnGateways.create",
    "compute.googleapis.com/targetVpnGateways.delete",
    "compute.googleapis.com/targetVpnGateways.setLabels",
    "compute.googleapis.com/targetVpnGateways.use",
    "compute.googleapis.com/vpnGateways.create",
    "compute.googleapis.com/vpnGateways.delete",
    "compute.googleapis.com/vpnGateways.setLabels",
    "compute.googleapis.com/vpnGateways.use",
    "compute.googleapis.com/vpnTunnels.create",
    "compute.googleapis.com/vpnTunnels.delete",
    "compute.googleapis.com/vpnTunnels.setLabels",
    # IAM override permissions
    "iam.googleapis.com/roles.create",
    "iam.googleapis.com/roles.delete",
    "iam.googleapis.com/roles.undelete",
    "iam.googleapis.com/roles.update",
    "iam.googleapis.com/serviceAccountKeys.create",
    "iam.googleapis.com/serviceAccountKeys.delete",
    "iam.googleapis.com/serviceAccounts.getAccessToken",
    "iam.googleapis.com/serviceAccounts.getOpenIdToken",
    "iam.googleapis.com/serviceAccounts.implicitDelegation",
    "iam.googleapis.com/serviceAccounts.signBlob",
    "iam.googleapis.com/serviceAccounts.signJwt",
    # WorkloadIdentity permissions
    "iam.googleapis.com/workloadIdentityPoolProviders.delete", #v2, originally identityplatform.workloadPoolProviders.[perm] in v1
    "iam.googleapis.com/workloadIdentityPoolProviders.undelete",
    "iam.googleapis.com/workloadIdentityPoolProviders.update",
    "iam.googleapis.com/workloadIdentityPools.create", #v2, originally identityplatform.workloadPools.[perm] in v1
    "iam.googleapis.com/workloadIdentityPools.delete",
    "iam.googleapis.com/workloadIdentityPools.undelete",
    "iam.googleapis.com/workloadIdentityPools.update",
    "cloudresourcemanager.googleapis.com/projects.createBillingAssignment", #v2, in v1 this was just resourcemanager
    "cloudresourcemanager.googleapis.com/projects.delete",
    "cloudresourcemanager.googleapis.com/projects.deleteBillingAssignment",
    "cloudresourcemanager.googleapis.com/projects.move",
    "cloudresourcemanager.googleapis.com/projects.undelete",
    "cloudresourcemanager.googleapis.com/projects.update",
    "cloudresourcemanager.googleapis.com/projects.updateLiens",
    "cloudresourcemanager.googleapis.com/projects.setIamPolicy",
    # security command center mutable
    "securitycenter.googleapis.com/assets.group",
    "securitycenter.googleapis.com/assetsecuritymarks.update",
    "securitycenter.googleapis.com/findings.group", 
    "securitycenter.googleapis.com/findings.setState",
    "securitycenter.googleapis.com/findings.update",
    "securitycenter.googleapis.com/notificationconfig.create",
    "securitycenter.googleapis.com/notificationconfig.delete",
    "securitycenter.googleapis.com/notificationconfig.update",
    "securitycenter.googleapis.com/sources.setIamPolicy",
    "securitycenter.googleapis.com/sources.update",
    "servicenetworking.googleapis.com/services.addPeering",
    "servicenetworking.googleapis.com/services.addSubnetwork",
    "serviceusage.googleapis.com/services.enable",
    "serviceusage.googleapis.com/services.disable",
    "apikeys.googleapis.com/keys.create", #V2 - Note that serviceusage.apiKeys.* (v1) is same as apikeys.googleapis.com/keys.*
    "apikeys.googleapis.com/keys.delete",
    "apikeys.googleapis.com/apiKeys.regenerate",
    "apikeys.googleapis.com/apiKeys.revert",
    "apikeys.googleapis.com/keys.update",
    "storage.googleapis.com/hmacKeys.delete",
    "storage.googleapis.com/hmacKeys.get",  
    "storage.googleapis.com/hmacKeys.list", 
    "storage.googleapis.com/hmacKeys.update",
    # prevent creating long-lived HMAC key
    "storage.googleapis.com/hmacKeys.create",
  ]
}