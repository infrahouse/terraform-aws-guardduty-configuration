locals {
  module_version = "5.3.0"

  module_name = "infrahouse/guardduty-configuration/aws"
  default_module_tags = merge(
    {
      created_by_module : local.module_name
      module_version = local.module_version
    },
    var.tags
  )
}

