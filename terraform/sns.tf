resource "aws_sns_topic" "scale_down" {
  name = "scale_down"
}

resource "aws_sns_topic_subscription" "scale_down-email-target" {
  topic_arn = aws_sns_topic.scale_down.arn
  protocol  = "email"
  endpoint  = "said.farhi72@gmail.com"
}

resource "aws_sns_topic" "scale_up" {
  name = "scale_up"
}

resource "aws_sns_topic_subscription" "scale_up-email-target" {
  topic_arn = aws_sns_topic.scale_up.arn
  protocol  = "email"
  endpoint  = "said.farhi72@gmail.com"
}
