terraform {
  backend "s3" {
    bucket = "<s3_bucket_name>"
    key    = "<s3_bucket_file_key>"
    region = "<aws_target_region>"
  }
}
