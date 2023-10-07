# Policy name match to the policy file name
variable "avicontroller_policies" {
  type        = list(string)
  description = "avicontroller policy list"
  default     = ["avicontroller-ec2-policy", "avicontroller-s3-policy", "avicontroller-iam-policy", "avicontroller-r53-policy", "avicontroller-asg-policy", "avicontroller-sqs-sns-policy", "avicontroller-kms-policy"]
}

# Policy name match to the policy file name
variable "vmimport_policies" {
  type        = list(string)
  description = "vmimport policy list"
  default     = ["vmimport-role-policy", "avicontroller-kms-vmimport"]
}
