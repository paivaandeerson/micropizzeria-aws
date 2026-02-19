
resource "aws_sns_topic" "order-confirmed-topic" {
    name = "order-confirmed-topic"
    display_name = "order-confirmed-topic"
    tags = var.aws_tags
}

resource "aws_sns_topic" "order-finished-topic" {
    name = "order-finished-topic"
    display_name = "order-finished-topic"
    tags = var.aws_tags
}


resource "aws_sns_topic" "ready-for-delivery-topic" {
    name = "ready-for-delivery-topic"
    display_name = "ready-for-delivery-topic"
    tags = var.aws_tags
}

//TODO: policy to publish and get