#                   _       _     _            _    __ 
#                  (_)     | |   | |          | |  / _|
#  __   ____ _ _ __ _  __ _| |__ | | ___  ___ | |_| |_ 
#  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|| __|  _|
#   \ V / (_| | |  | | (_| | |_) | |  __/\__ \| |_| |  
#    \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___(_)__|_|  
                                                    
#=========================#
# Variables Declared Here #
#=========================#
                                                           

variable "region" {
    type        = string
    description = "Used to specify the region to deploy our resources to and apply to naming conventions."


validation {
    condition     = lower(var.region) == "us-east-1" || lower(var.region) == "us-east-2" || lower(var.region) == "us-west-1" || lower(var.region) == "us-west-2"
    error_message = "Not a supported region." 
    }
}

variable "env" {
    type        = string
    description = "Used in naming conventions and tagging to identify the environment type"

validation {
    condition     = contains(["prod", "non-prod", "dev", "test", "sandbox", "stage"], var.env)
    error_message = "Not a valid environment type." 
    }
}

variable "instance_type" {
    type = string
}

variable "org_name" {
    type        = string
    description = "The name of the organization used for naming convention and tagging. Must be less than 6 characters"

validation {
    condition     = length(var.org_name) <= 10
    error_message = "Not a valid org." 
    }
}

variable "availability_zones" {
    type        = map(string)
    description = "A map of availability zones used for naming convention and logic." 
}

variable "region_codes" {
    type        = map(string)
    description = "A map of azs for a specific region" 
}

variable "cidr_block" {
    type        = string
    description = "This variable represents our VPC CIDR block that will apply to the VPC resource itself and can be referenced elsewhere."
}

variable "borrowed_bits" {
    type = number
}
