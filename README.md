# Real-Time Analytics with Spark Streaming Terraform Module

This Terraform module simplifies the deployment of infrastructure required for real-time analytics with Spark Streaming version 1.3 on AWS.

## Usage

To use this module, include it in your Terraform configuration:

```hcl
module "real_time_analytics" {
  source = "path/to/module"
  
  # Specify input variables here
}

#---------------------------------------------------------------------------------

# Clone the repository
git clone <repository_url>
cd <repository_directory>

# Initialize Terraform
terraform init

# Review and Modify Input Variables (if needed)
# Open main.tf file and adjust input variables as necessary

# Plan the Deployment
terraform plan

# Apply the Configuration
terraform apply

# Verify Deployment
# After Terraform finishes applying the configuration, verify that the infrastructure has been deployed successfully. You can check the AWS Management Console or use AWS CLI commands to inspect the resources.

# Optional: Destroy Resources
# If you want to tear down the resources created by Terraform, you can run the following command:
# terraform destroy
# This will remove all resources created by Terraform in the environment.




  Make sure to replace "path/to/module" with the actual path to the module.



**Inputs**

stream_name:                    Name of the Kinesis data stream
shard_count:                    Number of shards for the Kinesis data stream
retention_period:               Retention period for Kinesis data stream (hours)
firehose_bucket:                Name of the S3 bucket for Kinesis Data Firehose
firehose_name:                  Name of the Kinesis Data Firehose delivery stream
buffer_size:                    Buffer size for Kinesis Data Firehose (MB)
buffer_interval:                Buffer interval for Kinesis Data Firehose (seconds)
compression_format:             Compression format for Kinesis Data Firehose
firehose_role_name:             Name of the IAM role for Kinesis Data Firehose
firehose_policy_name:           Name of the IAM policy for Kinesis Data Firehose
s3_actions:                     List of S3 actions for the IAM policy
dashboard_name:                 Name of the CloudWatch dashboard
alarm_name:                     Name of the CloudWatch alarm
comparison_operator:            omparison operator for the CloudWatch alarm
evaluation_periods:             Number of evaluation periods for the CloudWatch alarm
period:                         Period for the CloudWatch alarm (seconds)
statistic:                      tatistic for the CloudWatch alarm
threshold:                      Threshold value for the CloudWatch alarm
alarm_actions:                  List of actions to be triggered by the CloudWatch alarm




**Example**


module "real_time_analytics" {
  source = "path/to/module"
  
  stream_name          = "exampleStream"
  shard_count          = 1
  retention_period     = 24
  firehose_bucket      = "firehose-target-bucket"
  firehose_name        = "exampleFirehose"
  buffer_size          = 10
  buffer_interval      = 400
  compression_format   = "GZIP"
  firehose_role_name   = "firehose_delivery_role"
  firehose_policy_name = "firehose_to_s3_policy"
  s3_actions           = [
    "s3:AbortMultipartUpload",
    "s3:GetBucketLocation",
    "s3:GetObject",
    "s3:ListBucket",
    "s3:ListBucketMultipartUploads",
    "s3:PutObject"
  ]
  dashboard_name       = "FirehoseMonitoring"
  alarm_name           = "high-incoming-records"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = 1
  period               = 300
  statistic            = "Average"
  threshold            = 1000
  alarm_actions        = ["<insert your notification action, e.g., SNS topic ARN>"]
}





**Outputs**


stream_name:                   Name of the Kinesis data stream
stream_arn:                    ARN of the Kinesis data stream
firehose_bucket_name:          Name of the S3 bucket for Kinesis Data Firehose
firehose_role_arn:             ARN of the IAM role for Kinesis Data Firehose
firehose_delivery_stream_name: Name of the Kinesis Data Firehose delivery stream
dashboard_name:                Name of the CloudWatch dashboard
alarm_name:                    Name of the CloudWatch alarm
