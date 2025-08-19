
    terraform {
      backend "s3" {
        bucket = "deploy-aws-eks-restapi-repo"
        key = "eks-restapi/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "terraform-eks-restapi-lock"
      }
    }
    