variable "stream_name" {
  description = "Name of the Kinesis data stream"
  type        = string
}

variable "shard_count" {
  description = "Number of shards for the Kinesis data stream"
  type        = number
  default     = 1
}

variable "retention_period" {
  description = "Retention period for Kinesis data stream in hours"
  type        = number
  default     = 24
}

variable "firehose_bucket" {
  description = "Name of the S3 bucket for Kinesis Data Firehose"
  type        = string
}

variable "firehose_name" {
  description = "Name of the Kinesis Data Firehose delivery stream"
  type        = string
}

variable "buffer_size" {
  description = "Buffer size for Kinesis Data Firehose in MB"
  type        = number
  default     = 10
}

variable "buffer_interval" {
  description = "Buffer interval for Kinesis Data Firehose in seconds"
  type        = number
  default     = 400
}

variable "compression_format" {
  description = "Compression format for Kinesis Data Firehose"
  type        = string
  default     = "GZIP"
}

variable "firehose_role_name" {
  description = "Name of the IAM role for Kinesis Data Firehose"
  type        = string
}

variable "firehose_policy_name" {
  description = "Name of the IAM policy for Kinesis Data Firehose"
  type        = string
}

variable "s3_actions" {
  description = "List of S3 actions for the IAM policy"
  type        = list(string)
  default     = [
    "s3:AbortMultipartUpload",
    "s3:GetBucketLocation",
    "s3:GetObject",
    "s3:ListBucket",
    "s3:ListBucketMultipartUploads",
    "s3:PutObject"
  ]
}

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
}

variable "comparison_operator" {
  description = "Comparison operator for the CloudWatch alarm"
  type        = string
}

variable "evaluation_periods" {
  description = "Number of evaluation periods for the CloudWatch alarm"
  type        = number
}

variable "period" {
  description = "Period for the CloudWatch alarm in seconds"
  type        = number
}

variable "statistic" {
  description = "Statistic for the CloudWatch alarm"
  type        = string
}

variable "threshold" {
  description = "Threshold value for the CloudWatch alarm"
  type        = number
}

variable "alarm_actions" {
  description = "List of actions to be triggered by the CloudWatch alarm"
  type        = list(string)
}
