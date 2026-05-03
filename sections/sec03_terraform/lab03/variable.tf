variable "region" {
  type = string
  default = "ap-southeast-2"
}

variable "ami_chosen" {
  type = map(any)
  default = {
    "ap-northeast-1" : "ami-0a21a03072be95559"
    "ap-southeast-2" : "ami-082b6a99fff8987dc"
  }
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.micro"
  default = "t3.micro"
}



