variable "gcp_project" {
  description = "The ID of the project where the infrastructure will be created."
  type        = string
}

variable "labels" {
  description = "Map of key/value pairs to label all resources with"
  type        = map(string)
  default = {
    "environment" = "beradev"
  }
}

variable "gcp_region" {
  description = "The region where the infrastructure will be created."
  type        = string
  default     = "us-central1"
}

variable "name" {
  description = "The name to prefix all resources with"
  type        = string
  default     = "bera"
}

variable "subnet_cidr" {
  description = "The IP range of the subnet."
  type        = string
  default     = "10.0.0.0/24"
}

variable "machine_type" {
  description = "The machine type of the virtual machine instance."
  type        = string
  default     = "n1-standard-2"
}

variable "boot_disk_image" {
  description = "The name or self_link of the image to use for the virtual machine's boot disk."
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "data_disk_size" {
  description = "The size of the persistent disk in GB."
  type        = string
  default     = 200
}

variable "data_disk_type" {
  description = "The type of the persistent disk."
  type        = string
  default     = "pd-ssd"
}
