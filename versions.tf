terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # or any other version you prefer
    }
  }

  required_version = ">= 1.0"
}

# this file is used to assist the Jenkinsfile to create end to end pipeline for the Jenkins server