# -------------------------------
# GCP Project Configuration
# -------------------------------
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be created"
  type        = string
  default     = "us-central1"
}


# -------------------------------
# VPC Configuration
# -------------------------------
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "routing_mode" {
  description = "Routing mode for the VPC (GLOBAL or REGIONAL)"
  type        = string
  default     = "REGIONAL"

  validation {
    condition     = contains(["GLOBAL", "REGIONAL"], var.routing_mode)
    error_message = "routing_mode must be either GLOBAL or REGIONAL."
  }
}

variable "auto_create_subnetworks" {
  description = "Whether to auto-create subnetworks"
  type        = bool
  default     = false
}

variable "allowed_ports" {
  description = "List of allowed TCP ports for firewall"
  type        = list(string)
}


# -------------------------------
# Subnet Configuration
# -------------------------------
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "ip_cidr_range" {
  description = "CIDR range for the subnet"
  type        = string

  validation {
    condition     = can(cidrhost(var.ip_cidr_range, 0))
    error_message = "The ip_cidr_range must be a valid CIDR block."
  }
}

# -------------------------------
# Compute Configuration
# -------------------------------

variable "zone" {
  description = "The GCP zone where resources will be created"
  type        = string
  default     = "us-central1-f"
}

variable "machine_type" {
  type        = string
  default     = "e2-standard-4"
  description = "The machine type for the instance"
}

variable "machine_name" {
  type        = string
  default     = "ComputeInstance"
  description = "The name of the compute instance"
}

