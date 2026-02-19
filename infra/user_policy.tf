resource "aws_iam_policy" "micropizzeria_policy" {
    name = "micropizzeria_access"
    path = "/"
    description = "Micropizzeria Policy"
    policy = <<EOF
    {
        "Version" //TODO: Finish
    }
EOF
}

resource "aws_iam_policy_attachment" "attach_policy" {
    users = [data.aws_iam_user.micropizzeria_user.user_name]
    policy_arn = aws_iam_policy.statement_policy.policy_arn
    name = "attachment_policy"
}