# Written by ChatPGT
#!/bin/bash

# AWS CLI profile and region
REGION="us-east-2"

# CloudFormation stack details
STACK_NAME="my-demostack"
TEMPLATE_FILE="main.yaml"
PARAMETERS="Region=us-east-2"
CAPABILITIES="CAPABILITY_IAM"

# Check if stack exists
if aws cloudformation describe-stacks --region "$REGION" --stack-name "$STACK_NAME" &>/dev/null; then
    echo "Stack $STACK_NAME exists. Updating..."
    aws cloudformation update-stack --profile "$PROFILE" --region "$REGION" --stack-name "$STACK_NAME" --template-body "file://$TEMPLATE_FILE" --capabilities "$CAPABILITIES" --parameters ParameterKey=Region,ParameterValue=us-east-2 
else
    echo "Stack $STACK_NAME does not exist. Creating..."
    aws cloudformation deploy --region "$REGION" --stack-name "$STACK_NAME" --template-file "$TEMPLATE_FILE" --parameter-overrides $PARAMETERS --capabilities "$CAPABILITIES"
fi
