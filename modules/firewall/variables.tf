variable "firewall_name" {
  description = "The name of the firewall"
  type        = string
}

variable "network_name" {
  description = "The name of the network to apply the firewall rule to"
  type        = string
}

variable "allowed_ports" {
  description = "The list of ports that are allowed by the firewall"
  type        = list(number)
  default     = [80, 443]
}

variable "source_ranges" {
  description = "The list of source IP ranges that are allowed by the firewall"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
