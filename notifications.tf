resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  name        = "GuardDutyFindings"
  description = "Capture GuardDuty findings"
  event_pattern = jsonencode(
    {
      "source" : ["aws.guardduty"],
      "detail-type" : ["GuardDuty Finding"]
    }
  )
  tags = local.default_module_tags
}

resource "aws_cloudwatch_event_target" "notify_target" {
  rule     = aws_cloudwatch_event_rule.guardduty_findings.name
  arn      = aws_sns_topic.notifications.arn
  role_arn = aws_iam_role.guardduty.arn
}

resource "aws_sns_topic" "notifications" {
  name_prefix = "guardduty-"
  tags        = local.default_module_tags
}

resource "aws_sns_topic_subscription" "emails" {
  endpoint  = var.notifications_email
  protocol  = "email"
  topic_arn = aws_sns_topic.notifications.arn
}
