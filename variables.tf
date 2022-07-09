variable "accountOwner" {
  description = "Account owner for vpc"
  default = "<aws account number>"
}
variable "VPCnames" {
  type = list(string)
  default = ["etk", "tc0", "epa", "epa-bi-efile"]
}
variable "oldEc2" {
  type = list(string)
  default = [ "<instance id's>",  ]
}