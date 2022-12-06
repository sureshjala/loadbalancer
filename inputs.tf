variable "vpc_id" {
    type = string
    default = "vpc-02d8b88598286e08d"
  
}
variable "tags_tg" {
    type = list(string)
    default = [ "target1", "target2" ]
  
}
variable "region" {
    type = string
    default = "us-west-2"
  
}
variable "subnet" {
    type = list(string)
    default = [ "subnet-0202045356b1c119b", "subnet-021eca06684b7129b" ]
     
}
variable "availability_zone" {
    type = list(string)
    default = [ "us-west-2a", "us-west-2c" ]
  
}
variable "instance_type" {
    type = string
    default = "t2.micro"
  
}
variable "security_groups" {
    type = string
    default = "sg-06ca35c08399b1122"
  
}
variable "key_name" {
    type = string
    default = "id_rsa"
  
}
variable "tags" {
    type = list(string)
    default = [ "admin","order" ]
  
}
variable "server-trigger" {
    type = string
    description = "giving the trigger to the null resource"
    default = "1.5"
}
