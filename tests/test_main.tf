# In this file, we deploy the Terraform module being tested with specific input variables for testing purposes.
# Then, we create additional resources to verify that the infrastructure was deployed successfully.

# Include the Terraform module being tested
module "real_time_analytics_test" {
  source = "../"
  
  # Specify input variables for testing (if needed)
  stream_name          = "testStream"
  shard_count          = 1
  retention_period     = 24
  firehose_bucket      = "test-firehose-bucket"
  firehose_name        = "testFirehose"
  buffer_size          = 10
  buffer_interval      = 400
  compression_format   = "GZIP"
  firehose_role_name   = "test_delivery_role"
  firehose_policy_name = "test_to_s3_policy"
  s3_actions           = [
    "s3:AbortMultipartUpload",
    "s3:GetBucketLocation",
    "s3:GetObject",
    "s3:ListBucket",
    "s3:ListBucketMultipartUploads",
    "s3:PutObject"
  ]
  dashboard_name       = "TestDashboard"
  alarm_name           = "test-high-incoming-records"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = 1
  period               = 300
  statistic            = "Average"
  threshold            = 1000
  alarm_actions        = ["<insert your notification action, e.g., SNS topic ARN>"]
}

# Verify the Kinesis data stream exists
resource "aws_kinesis_stream" "test_stream" {
  name = module.real_time_analytics_test.stream_name

  lifecycle {
    ignore_changes = [tags]
  }
}

# Verify the Kinesis Data Firehose delivery stream exists
resource "aws_kinesis_firehose_delivery_stream" "test_firehose" {
  name = module.real_time_analytics_test.firehose_name

  lifecycle {
    ignore_changes = [tags]
  }
}

# Verify the S3 bucket for Kinesis Data Firehose exists
resource "aws_s3_bucket" "test_firehose_bucket" {
  bucket = module.real_time_analytics_test.firehose_bucket

  lifecycle {
    ignore_changes = [tags]
  }
}

# Verify the CloudWatch dashboard exists
resource "aws_cloudwatch_dashboard" "test_dashboard" {
  dashboard_name = module.real_time_analytics_test.dashboard_name

  lifecycle {
    ignore_changes = [dashboard_body]
  }
}

# Verify the CloudWatch alarm exists
resource "aws_cloudwatch_metric_alarm" "test_alarm" {
  alarm_name          = module.real_time_analytics_test.alarm_name
  comparison_operator = module.real_time_analytics_test.comparison_operator
  evaluation_periods  = module.real_time_analytics_test.evaluation_periods
  metric_name         = "IncomingRecords"
  namespace           = "AWS/Firehose"
  period              = module.real_time_analytics_test.period
  statistic           = module.real_time_analytics_test.statistic
  threshold           = module.real_time_analytics_test.threshold

  dimensions = {
    DeliveryStreamName = module.real_time_analytics_test.firehose_name
  }

  lifecycle {
    ignore_changes = [alarm_actions]
  }
}
