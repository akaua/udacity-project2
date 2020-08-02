# main.tfvars
variable "ami" {
    type        = "string"
    description = "AMI for ec2 instances"
}

variable "instance_type_T2" {
    type        = "string"
    description = "Instance type for ec2 machines"
}

variable "instance_count_T2" {
    type        = "string"
    description = "number of instances"
}

variable "instance_type_M4" {
    type        = "string"
    description = "Instance type for ec2 machines"
}

variable "instance_count_M4" {
    type        = "string"
    description = "number of instances"
}
