terraform {
    backend "s3" {
        bucket = "udacity-akaua-tf-backend"
        key = "projeto/instancias/terraform.tfstate" 
        region = "us-east-1"
    }
}