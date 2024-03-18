output "stream_name" {
  description = "Name of the Kinesis data stream"
  value       = aws_kinesis_stream.analytics_stream.name
}

output "stream_arn" {
  description = "ARN of the Kinesis data stream"
  value       = aws_kinesis_stream.analytics_stream.arn
}

output "firehose_bucket_name" {
  description = "Name of the S3 bucket for Kinesis Data Firehose"
  value       = aws_s3_bucket.firehose_target.bucket
}

output "firehose_role_arn" {
  description = "ARN of the IAM role for Kinesis Data Firehose"
  value       = aws_iam_role.firehose_role.arn
}

output "firehose_delivery_stream_name" {
  description = "Name of the Kinesis Data Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.analytics_firehose.name
}

output "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.analytics_dashboard.dashboard_name
}

output "alarm_name" {
  description = "Name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.firehose_incoming_records_alarm.alarm_name
}
