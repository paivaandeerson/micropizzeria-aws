resource "aws_sqs_queue_policy" "order_sqs_queue_policy" {
    queue_url = aws_sqs_queue.order-queue.id
    policy = <<POLICY
    {
        "Version" //TODO: Finish
    }
POLICY
}

resource "aws_sqs_queue_policy" "order_sqs_queue_dlq_policy" {
    queue_url = aws_sqs_queue.order-queue_dlq.id
    policy = <<POLICY
    {
        "Version" //TODO: Finish
    }
POLICY
}

//policy to list, put, get, delete, purge, receive and send