output "cloudfront-domain" {
  description = "cloudfront domain name"
  value =  aws_cloudfront_distribution.cf_distribution.domain_name
}

output "origin-bucket" {
  description = "s3 origin bucket"
  value = aws_s3_bucket.origin_bucket.bucket
}