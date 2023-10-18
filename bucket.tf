#bucket
resource "aws_s3_bucket" "origin_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = local.common_tags
  provider      = aws.frankfurt
}

#bucket versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.origin_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.origin_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#attach the bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.origin_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}  

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.origin_bucket.id
  key = "index.html"
  content = "<h1>Hello, world</h1>"
  content_type = "text/html"
}