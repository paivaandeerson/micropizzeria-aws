# Get IAM User 
data "aws_iam_user" "micropizzeria_user" {
    user_name = "micropizzeria"
}

#SNS
data "aws_sns_topic" "order-confirmed-topic" {
    name = "order-confirmed-topic"
}

data "aws_sns_topic" "order-finished-topic" {
    name = "order-finished-topic"
}

data "aws_sns_topic" "ready-for-delivery-topic" {
    name = "ready-for-delivery-topic"
}