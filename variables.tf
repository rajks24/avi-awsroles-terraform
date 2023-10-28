# Avicontroller IAM policies
variable "avicontroller_policies" {
  type = map(object({
    name        = string
    description = string
    policy      = string
  }))
  description = "avicontroller policy list"
  default     = {}
}

# vmimport policies to be used for managing VM for SE
variable "vmimport_policies" {
  type = map(object({
    name        = string
    description = string
    policy      = string
  }))
  description = "vmimport policy list"
  default     = {}
}
