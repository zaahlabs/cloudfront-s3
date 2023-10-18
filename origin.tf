data "aws_iam_user" "s3_user" {
  user_name = var.iam_user
}

#cloudfront origin access identity
resource "aws_cloudfront_origin_access_identity" "oai_origin" {
  comment = "Origin access Identity for origin bucket"
}

#bucket policy with oai
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "DenyIncorrectEncryptionHeader"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.origin_bucket.arn}/*"]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "AES256",
      ]
    }
  }

  statement {
    sid = "DenyUnencryptedObjectUploads"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.origin_bucket.arn}/*"]
    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "true",
      ]
    }
  }

  statement {
    sid = "AllowOAIGetObject"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai_origin.iam_arn]
    }
    actions   = ["s3:GetObject","s3:GetObjectVersion"]
    resources = ["${aws_s3_bucket.origin_bucket.arn}/*"]
  }

  statement {
    sid = "AllowOAIListBucket"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai_origin.iam_arn]
    }
    actions   = ["s3:Listbucket"]
    resources = [aws_s3_bucket.origin_bucket.arn]
  }

  statement {
    sid = "AllowUserPutObject"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_user.s3_user.arn]
    }
    actions   = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      ]
    resources = ["${aws_s3_bucket.origin_bucket.arn}/data/*"]
  }
}