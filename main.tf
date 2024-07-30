provider "aws" {
  region = "us-east-1"
}

# Create S3 buckets for all environments
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.common_name}-${var.env}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "${var.common_name}-${var.env}"
    Environment = var.env
  }
}

resource "aws_s3_bucket_public_access_block" "policy" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject"
        ],
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      }
    ]
  })
}