terraform {
  backend "s3" {
    bucket = "avaiizur-terraform-state-20260914-27424"
    key    = "aws-devops-rhel-lab/dev/terraform.tfstate"
    region = "eu-west-2"
  }
}