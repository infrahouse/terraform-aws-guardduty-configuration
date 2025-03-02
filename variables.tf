variable "notifications_email" {
  description = "Email to send GuardDuty finding notifications"
}

variable "tags" {
  description = "Tags to apply to resources created by the module."
  type        = map(string)
  default     = {}
}
