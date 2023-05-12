
variable "zone" {
  type        = string
  description = "the zone in which policy will be created"
  default     = "us-central1-c"
}

variable "region" {
  type        = string
  description = "the region where project resides"
  default     = "us-central1"
}

variable "path" {
  type    = string
  default = "cloudresourcemanager.googleapis.com/folders/"
}

variable "iamdeny_folder_path" {
  type    = string
  default = "cloudresourcemanager.googleapis.com/folders/"
}

variable "iamdeny_folder_id" {
  description = "The folder ID to place the policy within."
  type        = string
  default     = "" 
}

variable "networking_exception_principals" {
  type        = list(string)
  description = "The id of the google group associated with your networking team. Follows the format principalSet://goog/group/GROUP_EMAIL_ADDRESS" #https://cloud.google.com/iam/docs/principal-identifiers for wider syntax
  default     = [""]
}

variable "billing_exception_principals" {
  type        = list(string)
  description = "The id of the google group associated with your billing team. Follows the format principalSet://goog/group/GROUP_EMAIL_ADDRESS"
  default     = [""]
}

variable "dns_exception_principals" {
  type        = list(string)
  description = "A list of excluded principals from an IAM Deny Policy. Follows the format principalSet://goog/group/GROUP_EMAIL_ADDRESS"
  default     = [""]
}

variable "iamdeny_tester_exception_principals" {
  type        = list(string)
  description = "A list of excluded principals from an IAM Deny Policy. Follows the format principalSet://goog/group/GROUP_EMAIL_ADDRESS"
  default     = ["principal://goog/subject/kevinaschmidt@google.com"]
}
