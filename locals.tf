#   _                 _      _    __ 
#  | |               | |    | |  / _|
#  | | ___   ___ __ _| |___ | |_| |_ 
#  | |/ _ \ / __/ _` | / __|| __|  _|
#  | | (_) | (_| (_| | \__ \| |_| |  
#  |_|\___/ \___\__,_|_|___(_)__|_|  
                            

#===========================#
# Local Values Defined Here #
#===========================#


locals {

#=============#
# Name Prefix #
#=============#

name_prefix = "${var.org_name}-${local.region_code}-${var.env}"


#===================#
# Region Map Lookup #
#===================#


    region_map = {
        "us-east-1" = "use1"
        "us-east-2" = "use2"
        "us-west-1" = "usw1"
        "us-west-2" = "usw2"
    }
    region_code = lookup(local.region_map, var.region)


    availability_zones = {
        0 = "${var.region}a"
        1 = "${var.region}b"
}



}
