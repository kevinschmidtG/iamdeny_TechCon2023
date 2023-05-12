variable "folder_id" {
  type        = string
  description = "The resource name of the parent Folder or Organization. Must be of the form folder_id or org_id"
}

variable "organization_id" {
  type        = string
  description = "The resource name of the parent Folder or Organization. Must be of the form folder_id or org_id"
  default     = ""
}