
resource "aws_s3_bucket" "status-bucket" {
    bucket = "status-bucket"
    acl = "private"
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = "" //TODO: to finish
          sse_algorithm = "aws:kms"
        }
      }
    }
}

//policy to list, put, get, delete e encrypt