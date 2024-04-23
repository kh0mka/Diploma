# Generic variables

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "tags_for_resource" {
  description = "A nested map of tags to assign to specific resource types"
  type        = map(map(string))
  default = {
    aws_sg = {
      "Name"        = "Security group for Static Web-Server"
      "Description" = "Created using the security-group module"
      "Section"     = "Terraform"
      "Task"        = "4"
    }
  }
}

# SG variables

variable "dynamic_ingress" {
  type    = list(string)
  default = []
}

variable "vpc_id" {
  type    = string
  default = ""
}
