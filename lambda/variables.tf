# TODO: Define the variable for aws_region

# main.tfvars
variable "aws_region" {
    type        = "string"
    description = "AWS Region to create lambda"
    default     = "us-east-1"
}


