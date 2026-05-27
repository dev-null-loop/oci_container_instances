variable "availability_domain" {
  description = "(Required) The availability domain where the container instance runs."
  type        = string
}

variable "compartment_id" {
  description = "(Required) (Updatable) The compartment OCID."
  type        = string
}

variable "container_restart_policy" {
  description = "(Optional) Container restart policy"
  type        = string
  default     = null
}

variable "containers" {
  description = "(Required) The containers to create on this container instance."
  type = list(object({
    arguments             = optional(list(string), [])
    command               = optional(list(string), [])
    defined_tags          = optional(map(string))
    display_name          = optional(string)
    environment_variables = optional(map(string))
    freeform_tags         = optional(map(string), {})
    health_checks = optional(list(object({
      health_check_type = string
      failure_action    = optional(string)
      failure_threshold = optional(number)
      headers = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
      initial_delay_in_seconds = optional(number)
      interval_in_seconds      = optional(number)
      name                     = optional(string)
      path                     = optional(string)
      port                     = optional(number)
      success_threshold        = optional(number)
      timeout_in_seconds       = optional(number)
    })), [])
    image_url                      = string
    is_resource_principal_disabled = optional(bool)
    resource_config = optional(object({
      memory_limit_in_gbs = optional(number)
      vcpus_limit         = optional(number)
    }))
    security_context = optional(object({
      capabilities = optional(object({
        add_capabilities  = optional(list(string), [])
        drop_capabilities = optional(list(string), [])
      }))
      is_non_root_user_check_enabled = optional(bool)
      is_root_file_system_readonly   = optional(bool)
      run_as_group                   = optional(number)
      run_as_user                    = optional(number)
      security_context_type          = optional(string)
    }))
    volume_mounts = optional(list(object({
      is_read_only = optional(bool)
      mount_path   = string
      partition    = optional(number)
      sub_path     = optional(string)
      volume_name  = string
    })), [])
    working_directory = optional(string)
  }))
}

variable "defined_tags" {
  description = "(Optional) (Updatable) Defined tags for this resource. Each key is predefined and scoped to a namespace. Example: `{\"foo-namespace.bar-key\": \"value\"}`."
  type        = map(string)
  default     = null
}

variable "display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. If you don't provide a name, a name is generated automatically."
  type        = string
  default     = null
}

variable "dns_config" {
  description = "(Optional) Allow customers to define DNS settings for containers. If this is not provided, the containers use the default DNS settings of the subnet."
  type = object({
    nameservers = optional(list(string), [])
    options     = optional(list(string), [])
    searches    = optional(list(string), [])
  })
  default = null
}

variable "fault_domain" {
  description = "(Optional) The fault domain where the container instance runs."
  type        = string
  default     = null
}

variable "freeform_tags" {
  description = "(Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: `{\"bar-key\": \"value\"}`"
  type        = map(string)
  default     = {}
}

variable "graceful_shutdown_timeout_in_seconds" {
  description = "(Optional) The amount of time that processes in a container have to gracefully end when the container must be stopped. For example, when you delete a container instance. After the timeout is reached, the processes are sent a signal to be deleted."
  type        = string
  default     = null
}

variable "image_pull_secrets" {
  description = "(Optional) The image pulls secrets so you can access private registry to pull container images."
  type = list(object({
    password          = optional(string)
    registry_endpoint = string
    secret_id         = optional(string)
    secret_type       = string
    username          = optional(string)
  }))
  default = []
}

variable "shape" {
  description = "(Required) The shape of the container instance. The shape determines the resources available to the container instance."
  type        = string
}

variable "shape_config" {
  description = "(Required) The size and amount of resources available to the container instance."
  type = object({
    memory_in_gbs = optional(number)
    ocpus         = number
  })
}

variable "state" {
  description = "(Optional) (Updatable) The target state for the Container Instance. Could be set to `ACTIVE` or `INACTIVE`."
  type        = string
  default     = null
}

variable "vnics" {
  description = "(Required) The networks available to containers on this container instance."
  type = list(object({
    defined_tags           = optional(map(string))
    display_name           = optional(string)
    freeform_tags          = optional(map(string), {})
    hostname_label         = optional(string)
    is_public_ip_assigned  = optional(bool)
    nsg_ids                = optional(list(string), [])
    private_ip             = optional(string)
    skip_source_dest_check = optional(bool)
    subnet_id              = string
  }))
}

variable "volumes" {
  description = "(Optional) A volume is a directory with data that is accessible across multiple containers in a container instance."
  type = list(object({
    backing_store = optional(string)
    configs = optional(list(object({
      data      = optional(string)
      file_name = optional(string)
      path      = optional(string)
    })), [])
    name        = string
    volume_type = string
  }))
  default = []
}
