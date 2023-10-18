#cloudfront distribution
resource "aws_cloudfront_distribution" "cf_distribution" {
  provider = aws.virginia
  origin {
    domain_name = aws_s3_bucket.origin_bucket.bucket_regional_domain_name
    origin_id   = "s3_origin"
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.oai_origin.id}"
    }
  }

  enabled             = true
  comment             = "origin s3 bucket"
  price_class         = "PriceClass_100"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "s3_origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    default_ttl            = 14400 #4hr
    min_ttl                = 0
    max_ttl                = 14400 #4hr
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }
  ordered_cache_behavior {
    path_pattern     = "/data/*"
    target_origin_id = "s3_origin"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 3600 #1hr
    min_ttl                = 0
    max_ttl                = 14400 #4hr
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = local.common_tags
}
