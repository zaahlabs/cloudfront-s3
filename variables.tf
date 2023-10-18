#environment
variable "environment" {
  description = "Deployment environment"
  default = ""
}

#bucket
variable "bucket_name" {
  description = "name for bucket"
}

variable "iam_user" {
  description = "iam user to have write access to bucket"
}