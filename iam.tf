data "aws_iam_policy_document" "guardduty_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [
        "events.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "guardduty_permissions" {
  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [aws_sns_topic.notifications.arn]
    effect    = "Allow"
  }
}

resource "aws_iam_role" "guardduty" {
  name_prefix        = "guardduty-publish-"
  assume_role_policy = data.aws_iam_policy_document.guardduty_assume.json
  tags               = local.default_module_tags
}

resource "aws_iam_policy" "guardduty" {
  policy = data.aws_iam_policy_document.guardduty_permissions.json
  tags   = local.default_module_tags
}

resource "aws_iam_role_policy_attachment" "guardduty" {
  policy_arn = aws_iam_policy.guardduty.arn
  role       = aws_iam_role.guardduty.name
}
