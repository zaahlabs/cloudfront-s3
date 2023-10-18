#put the file in s3
resource "aws_s3_object" "package" {
  for_each = { for file in local.package_files : file => file }
  bucket = aws_s3_bucket.origin_bucket.id
  key = each.value
  source = "package/${each.key}"
  etag = filemd5("package/${each.key}")
  server_side_encryption = "AES256"

  #metadata
  content_disposition = "attachment; filename=\"hello-world.txt\""
  content_type = "text/plain"
}