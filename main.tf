resource "aws_guardduty_detector" "main" {
  enable = true
  tags   = local.default_module_tags
}

resource "aws_guardduty_detector_feature" "enabled" {
  for_each = toset(
    [
      "S3_DATA_EVENTS",
      "EBS_MALWARE_PROTECTION",
      "RDS_LOGIN_EVENTS",
      "LAMBDA_NETWORK_LOGS",
    ]
  )
  detector_id = aws_guardduty_detector.main.id
  name        = each.key
  status      = "ENABLED"
}

# This block to workaround a bug
# https://github.com/hashicorp/terraform-provider-aws/issues/36400

resource "aws_guardduty_detector_feature" "RUNTIME_MONITORING" {
  detector_id = aws_guardduty_detector.main.id
  name        = "RUNTIME_MONITORING"
  status      = "ENABLED"
  additional_configuration {
    name   = "EKS_ADDON_MANAGEMENT"
    status = "DISABLED"
  }
  additional_configuration {
    name   = "ECS_FARGATE_AGENT_MANAGEMENT"
    status = "DISABLED"
  }
  additional_configuration {
    name   = "EC2_AGENT_MANAGEMENT"
    status = "ENABLED"
  }

}
