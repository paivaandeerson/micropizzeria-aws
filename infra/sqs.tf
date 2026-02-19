resource "aws_sqs_queue" "order-queue" {
    name = "order-sqs"
    delay_seconds = 0
    max_message_size = 262144
    message_retention_seconds = 345600    
    receive_wait_time_seconds = 0
    visibility_timeout_seconds = 30
    tags = var.aws_tags
    redrive_policy = jsondecode({
        deadLetterTargetArn = aws_sqs_queue.order-queue_dlq.arn
        maxReceiveCount = 100
    })
}

resource "aws_sqs_queue" "order-queue_dlq" {
    name = "order-sqs_dlq"
    delay_seconds = 0
    max_message_size = 262144
    message_retention_seconds = 345600    
    receive_wait_time_seconds = 0
    visibility_timeout_seconds = 30
    tags = var.aws_tags
}
