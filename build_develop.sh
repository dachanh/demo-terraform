#!/bin/bash
export AWS_SECRET_ACCESS_KEY=AKIARNEXIJG5S6TOIWB6
export AWS_ACCESS_KEY_ID=E/kC/oqS3UCPrrooTabe/p+tLU0IdZa4QUFxYEla
# Read variable values from environment variables or other sources
bucket_name="amacho-develop-terraform-tfstate"
key_name="terraform.tfstate"
region="ap-northeast-2"
table_name="amacho-terraform-develop-state-lock"
role_arn="amcho-cuongnh-role"
account_id="096953977275"

# Replace placeholders in the backend configuration template
sed -e "s|<BUCKET_NAME>|$bucket_name|" \
    -e "s|<KEY_NAME>|$key_name|" \
    -e "s|<REGION>|$region|" \
    -e "s|<TABLE_NAME>|$table_name|" \
    -e "s|<ROLE_ARN>|$role_arn|"\
     -e "s|<ACCOUNT_ID>|$account_id|"\
    backend-template-develop.txt > backend.tf
cat backend.tf
# Run Terraform commands using the generated backend configuration
terraform init \
-backend-config="bucket=$bucket_name" \
  -backend-config="key=$key_name" \
  -backend-config="region=$region"

# terraform apply -var-file="develop.tfvars" -auto-approve