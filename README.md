# s3 basic authentication
version 1.0

## Getting Started

## Code
### bucket.tf
- Deploys s3 bucket with SSE-S3 in eu-central-1

### cloudfront.tf 
- Creates origin access identity. 
- Creates bucket policy that allows GetObject to origin access identity and forces encrypted uploads.
- Attaches bucket policy to s3 bucket in bucket.tf
- Uploads objects to be made available
- Creates cloudfront distribution in us-east-1 with origin set as the origin access identity. 
- Viewer protocol policy is set as redirect-to-https and lambda association to lambda created in lambda.tf

### iam.tf 
- Creates trust policy for lamda and edge IAM role. Creates IAM role and attaches a policy with lambda basic permissions. Associates the trust policy with the role.

### lambda.tf 
- Creates lambda function in us-east-1 with runtime NodeJs18 and attached to lambda role created in iam.tf Function code is uploaded from local files. 

### Prerequisites

### Deployment

### Push changes


