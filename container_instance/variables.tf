variable "compartment_id" {
  description = "(Required) (Updatable) The compartment OCID."
  type        = string
}

variable "availability_domain" {
  description = "(Required) The availability domain where the container instance runs."
  type        = number
  default     = 1
}

variable "fd" {
  description = "(Optional) The fault domain where the container instance runs."
  type        = number
  default     = 1
}

variable "display_name" {
  description = "(Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  type        = string
  default     = null
}

variable "container_restart_policy" {
  description = "(Optional) Container restart policy"
  type        = string
  default     = "ALWAYS"
}

variable "graceful_shutdown_timeout_in_seconds" {
  description = "(Optional) The amount of time that processes in a container have to gracefully end when the container must be stopped. For example, when you delete a container instance. After the timeout is reached, the processes are sent a signal to be deleted."
  type        = string
  default     = "0"
}

variable "state" {
  description = "(Optional) (Updatable) The target state for the Container Instance. Could be set to ACTIVE or INACTIVE."
  type        = string
  default     = "ACTIVE"
}

variable "shape" {
  description = "(Required) The shape of the container instance. The shape determines the resources available to the container instance."
  type        = string
  default     = "CI.Standard.E4.Flex"
}

variable "shape_config" {
  description = "(Required) The size and amount of resources available to the container instance."
  type = object({
    memory_in_gbs = number
    ocpus         = number
  })
  default = {
    memory_in_gbs = 1
    ocpus         = 1
  }
}

variable "containers" {
  description = "(Required) The containers to create on this container instance."
  type = map(object({
    image_url                      = string
    display_name                   = string
    environment_variables          = map(string)
    arguments                      = optional(list(string))
    command                        = optional(list(string))
    is_resource_principal_disabled = optional(string)
    defined_tags                   = optional(map(string))
    freeform_tags                  = optional(map(string))
    resource_config = optional(object({
      memory_limit_in_gbs = number
      vcpus_limit         = number
    }))
    volume_mounts = optional(map(object({
      mount_path   = string
      volume_name  = string
      is_read_only = optional(bool)
    })))
    working_directory = optional(string)
  }))
}

variable "vnics" {
  description = "(Required) The networks available to containers on this container instance."
  type = object({
    display_name           = optional(string)
    hostname_label         = optional(string)
    is_public_ip_assigned  = optional(string)
    nsg_ids                = optional(list(string))
    private_ip             = optional(string)
    skip_source_dest_check = optional(string)
    subnet_name            = string
    freeform_tags          = optional(map(string))
  })
}

variable "dns_config" {
  description = "(Optional) Allow customers to define DNS settings for containers. If this is not provided, the containers use the default DNS settings of the subnet."
  type = object({
    nameservers = optional(list(string))
    options     = optional(list(string))
    searches    = optional(list(string))
  })
  default = {}
}

variable "subnet_ids" {
  description = "(Required) The OCID of the subnet to create the VNIC in."
  type        = map(string)
  default = {
    public_subnet-vcn = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaaifysn4vhsag4gnebm3rdqxnxp4rvysmjvvbfobuhh6jjkvl66nma"
  }
}

variable "image_pull_secrets" {
  description = "(Optional) The image pulls secrets so you can access private registry to pull container images."
  type = object({
    registry_endpoint = string
    secret_type       = string
    secret_id         = optional(string)
    username          = optional(string)
    password          = optional(string)
  })
  default = null
}

variable "volumes" {
  description = "(Optional) A volume is a directory with data that is accessible across multiple containers in a container instance."
  type = map(object({
    name          = string
    volume_type   = string
    backing_store = optional(string)
    configs = optional(list(object({
      file_name = string
      data      = string
      path      = optional(string)
    })))
  }))
  default = null
}
