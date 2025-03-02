locals {
  module_version = "0.2.1"

  module_name = "infrahouse/guardduty-configuration/aws"
  default_module_tags = merge(
    {
      created_by_module : local.module_name
      module_version = local.module_version
    },
    var.tags
  )
}

