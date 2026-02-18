EC2 IAM Role with Inline Policies (Terraform Modules)
📌 Overview

This project provisions an EC2 instance with an attached IAM Role using official Terraform AWS modules.

The IAM Role contains inline policies that allow the EC2 instance to:

✅ Write to Amazon ECR

✅ Write to Amazon S3

✅ Connect to Database (RDS IAM Authentication example)

✅ Read from CloudWatch & CloudWatch Logs

All resources are created using Terraform modules only — no standalone IAM or EC2 resources.

Architecture
EC2 Instance
     │
     ▼
IAM Role (Instance Profile)
     │
     ├── ECR Write Access
     ├── S3 Write Access
     ├── DB Connect Access
     └── CloudWatch Read Access

     Modules Used

     terraform-aws-modules/iam/aws//modules/iam-role
Responsible for:

1️⃣ IAM Role Module

Attaching Inline Policy

Creating Instance Profile

2️⃣ EC2 Instance Module

terraform-aws-modules/ec2-instance/aws

Launching EC2 instance

Attaching IAM Instance Profile

Assigning subnet & security group

AM Permissions Explained
1️⃣ Amazon ECR Write Access

Allows EC2 to:

Authenticate to ECR

Push Docker images

Upload layers

Key actions:

ecr:GetAuthorizationToken

ecr:PutImage

ecr:UploadLayerPart

Use Case:

CI/CD pipeline pushing container images to ECR from EC2.

2️⃣ Amazon S3 Write Access

Allows EC2 to:

Upload objects to S3

Set ACL on uploaded objects

Key actions:

s3:PutObject

s3:PutObjectAcl

Use Case:

Application logs, artifacts, or backups stored in S3.

3️⃣ Database Connect Access

Uses IAM-based authentication for RDS.

Key action:

rds-db:connect

⚠ Note:
If database uses username/password authentication, IAM role is not required — only network + credentials.

4️⃣ CloudWatch Read Access

Allows EC2 to:

Read metrics

View log groups

Fetch log events

Key actions:

cloudwatch:GetMetricData

logs:GetLogEvents

Use Case:

Monitoring & debugging applications running on EC2.

📂 Project Structure
.
├── main.tf
├── variables.tf
├── versions.tf
├── terraform.tfvars
└── README.md

🚀 How to Deploy
1️⃣ Initialize Terraform
terraform init

2️⃣ Validate Configuration
terraform validate

3️⃣ Plan Deployment
terraform plan

4️⃣ Apply Changes
terraform apply

🔍 Why Inline Policies?

Inline policies are used because:

Permissions are tightly coupled to the role

No need for reuse across multiple roles

Simpler module-contained design

🔁 Policy Types Comparison
Policy Type	Reusable	AWS Controlled	Best For
Inline	❌ No	❌ No	Role-specific access
AWS Managed	✅ Yes	✅ Yes	Quick setup
Customer Managed	✅ Yes	❌ No	Enterprise production
🏢 Enterprise Considerations

For production environments:

Avoid "Resource": "*"

Scope permissions to specific ARNs

Use least-privilege principle

Consider customer-managed policies for shared access

Add IAM Conditions where possible

Example scoped S3 permission:

arn:aws:s3:::my-app-bucket/*

🛡 Security Best Practices

No hardcoded credentials

Uses IAM roles instead of access keys

Instance profile automatically rotates temporary credentials

Modular and version-controlled infrastructure

📌 Version Requirements

Terraform >= 1.3
AWS Provider >= 5.x

🎯 Use Cases

EC2-based CI/CD runners

Application servers pushing to ECR

Log shipping to S3

Monitoring-enabled workloads

Dev/Test environment provisioning

📎 Future Enhancements

Convert EC2 to Auto Scaling Group

Add Launch Template

Restrict IAM policies using Conditions

Parameterize all ARNs

Add environment-based naming convention

Add KMS encryption permissions

👤 Author

Ranjan Yadav
DevOps Engineer | Terraform | AWS | Kubernetes | DevSecOps
