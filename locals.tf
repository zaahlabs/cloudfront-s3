locals {
    common_tags = {
        project = "solution name"
        environment = var.environment
        managedby = "terraform"
        owner = "owner name"
    }
}

locals {
  # Path to the directory containing your Terraform files
  base_dir = path.root
}

locals {
  package_files = fileset("package", "**/*")
}