variable "aws_provider" {
    type = map

    default = {
        dev = {
            region = "us-east-1"
            workspace_iam_roles = "arn:aws:iam" //TODO: don't commit this value
            workspace_iam_id_roles = "arn:aws:iam" //TODO: don't commit this value
        }
        prd = {
            region = "us-east-1"
            workspace_iam_roles = "arn:aws:iam" //TODO: don't commit this value
            workspace_iam_id_roles = "arn:aws:iam" //TODO: don't commit this value
        }
    }
}

#AWS TAGS
variable "aws_tags" {
    type = map

    default = {
        dev = {
            "managed" = true
            "squad" = "xpto"
            "responsable" = "Anderson"
            "repository" = "https://github.com/repo-fake" //TODO: to finish
        }
    }
}