# Step 1: Kinesis Data Stream
resource "aws_kinesis_stream" "analytics_stream" {
  name           = var.stream_name
  shard_count    = var.shard_count
  retention_period = var.retention_period
  tags = var.tags
}

# Step 2: Kinesis Data Firehose to S3
resource "aws_s3_bucket" "firehose_target" {
  bucket = var.firehose_bucket
  acl    = "private"
}

resource "aws_kinesis_firehose_delivery_stream" "analytics_firehose" {
  name        = var.firehose_name
  destination = "s3"

  s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.firehose_target.arn
    buffer_size     = var.buffer_size
    buffer_interval = var.buffer_interval
    compression_format = var.compression_format
  }

  tags = var.tags
}

resource "aws_iam_role" "firehose_role" {
  name               = var.firehose_role_name
  assume_role_policy = jsonencode({
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "firehose.amazonaws.com"
      }
    }]
    Version   = "2012-10-17"
  })
}

resource "aws_iam_policy" "firehose_to_s3_policy" {
  name   = var.firehose_policy_name
  policy = jsonencode({
    Statement = [{
      Action   = var.s3_actions
      Effect   = "Allow"
      Resource = [
        aws_s3_bucket.firehose_target.arn,
        "${aws_s3_bucket.firehose_target.arn}/*"
      ]
    }]
    Version   = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "firehose_to_s3_attach" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.firehose_to_s3_policy.arn
}

# Step 3: CloudWatch Dashboard and Alarms
resource "aws_cloudwatch_dashboard" "analytics_dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/Firehose", "IncomingRecords", "DeliveryStreamName", aws_kinesis_firehose_delivery_stream.analytics_firehose.name],
            [".", "DeliveryToS3.Bytes", ".", "."]
          ]
          view     = "timeSeries"
          stacked  = false
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "firehose_incoming_records_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = "IncomingRecords"
  namespace           = "AWS/Firehose"
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  dimensions = {
    DeliveryStreamName = aws_kinesis_firehose_delivery_stream.analytics_firehose.name
  }
  alarm_actions = var.alarm_actions
}
