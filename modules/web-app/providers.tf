#                        _     _                _    __ 
#                       (_)   | |              | |  / _|
#   _ __  _ __ _____   ___  __| | ___ _ __ ___ | |_| |_ 
#  | '_ \| '__/ _ \ \ / / |/ _` |/ _ \ '__/ __|| __|  _|
#  | |_) | | | (_) \ V /| | (_| |  __/ |  \__ \| |_| |  
#  | .__/|_|  \___/ \_/ |_|\__,_|\___|_|  |___(_)__|_|  
#  | |                                                  
#  |_|                                                  

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
