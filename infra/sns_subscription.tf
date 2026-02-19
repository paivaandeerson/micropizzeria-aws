#FAN-OUT
resource "aws_sns_topic_subscription" "order-queue-target" {
    topic_arn = data.aws_sns_topic.order-confirmed-topic.arn
    protocol = "sqs"
    endpoint = aws_sqs_queue.order-queue.arn
    raw_message_delivery = true
}