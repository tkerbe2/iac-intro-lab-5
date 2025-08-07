#                                   _        _    __ 
#                                  | |      | |  / _|
#    ___ ___  _ __ ___  _ __  _   _| |_ ___ | |_| |_ 
#   / __/ _ \| '_ ` _ \| '_ \| | | | __/ _ \| __|  _|
#  | (_| (_) | | | | | | |_) | |_| | ||  __/| |_| |  
#   \___\___/|_| |_| |_| .__/ \__,_|\__\___(_)__|_|  
#                      | |                           
#                      |_|                           

#=================#
# Filter for AMI  #
#=================#

# Read notes in numerical order

data "aws_ami" "amazon_linux_2" {
 most_recent = true
 owners      = ["amazon"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

#=======================#
# EC2 Instance Resource #
#=======================#

resource "aws_instance" "lab_web_vm" {

  count                       = length(local.availability_zones)
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.lab_web_sn[count.index].id
  user_data                   = file("bootstrap.sh")
  security_groups             = [aws_security_group.web_servers_sg.id]

  tags = {
    
    Name        = "${local.name_prefix}-web-vm-${count.index + 1}"
    Environment = var.env
  }
}

#=====================#
# Elastic IP Resource #
#=====================#


resource "aws_eip" "lab_web_eip" {

 count = length(local.availability_zones)
  
  instance = aws_instance.lab_web_vm[count.index].id
  domain   = "vpc"
}
