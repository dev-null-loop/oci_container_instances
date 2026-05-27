resource "oci_container_instances_container_instance" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  dynamic "containers" {
    for_each = var.containers
    iterator = c
    content {
      image_url             = c.value.image_url
      arguments             = c.value.arguments
      command               = c.value.command
      defined_tags          = c.value.defined_tags
      display_name          = c.value.display_name
      environment_variables = c.value.environment_variables
      freeform_tags         = c.value.freeform_tags
      dynamic "health_checks" {
        for_each = c.value.health_checks
        iterator = hc
        content {
          health_check_type = hc.value.health_check_type
          failure_action    = hc.value.failure_action
          failure_threshold = hc.value.failure_threshold
          dynamic "headers" {
            for_each = hc.value.headers
            iterator = h
            content {
              name  = h.value.name
              value = h.value.value
            }
          }
          initial_delay_in_seconds = hc.value.initial_delay_in_seconds
          interval_in_seconds      = hc.value.interval_in_seconds
          name                     = hc.value.name
          path                     = hc.value.path
          port                     = hc.value.port
          success_threshold        = hc.value.success_threshold
          timeout_in_seconds       = hc.value.timeout_in_seconds
        }
      }
      is_resource_principal_disabled = c.value.is_resource_principal_disabled
      dynamic "resource_config" {
        for_each = c.value.resource_config[*]
        iterator = rc
        content {
          memory_limit_in_gbs = rc.value.memory_limit_in_gbs
          vcpus_limit         = rc.value.vcpus_limit
        }
      }
      dynamic "security_context" {
        for_each = c.value.security_context[*]
        iterator = sc
        content {
          dynamic "capabilities" {
            for_each = sc.value.capabilities[*]
            iterator = cap
            content {
              add_capabilities  = cap.value.add_capabilities
              drop_capabilities = cap.value.drop_capabilities
            }
          }
          is_non_root_user_check_enabled = sc.value.is_non_root_user_check_enabled
          is_root_file_system_readonly   = sc.value.is_root_file_system_readonly
          run_as_group                   = sc.value.run_as_group
          run_as_user                    = sc.value.run_as_user
          security_context_type          = sc.value.security_context_type
        }
      }
      dynamic "volume_mounts" {
        for_each = c.value.volume_mounts
        iterator = vm
        content {
          mount_path   = vm.value.mount_path
          volume_name  = vm.value.volume_name
          is_read_only = vm.value.is_read_only
          partition    = vm.value.partition
          sub_path     = vm.value.sub_path
        }
      }
      working_directory = c.value.working_directory
    }
  }
  shape = var.shape
  shape_config {
    ocpus         = var.shape_config.ocpus
    memory_in_gbs = var.shape_config.memory_in_gbs
  }
  dynamic "vnics" {
    for_each = var.vnics
    iterator = v
    content {
      subnet_id              = v.value.subnet_id
      defined_tags           = v.value.defined_tags
      display_name           = v.value.display_name
      freeform_tags          = v.value.freeform_tags
      hostname_label         = v.value.hostname_label
      is_public_ip_assigned  = v.value.is_public_ip_assigned
      nsg_ids                = v.value.nsg_ids
      private_ip             = v.value.private_ip
      skip_source_dest_check = v.value.skip_source_dest_check
    }
  }
  container_restart_policy = var.container_restart_policy
  defined_tags             = var.defined_tags
  display_name             = var.display_name
  dynamic "dns_config" {
    for_each = var.dns_config[*]
    iterator = dc
    content {
      nameservers = dc.value.nameservers
      options     = dc.value.options
      searches    = dc.value.searches
    }
  }
  fault_domain                         = var.fault_domain
  freeform_tags                        = var.freeform_tags
  graceful_shutdown_timeout_in_seconds = var.graceful_shutdown_timeout_in_seconds
  dynamic "image_pull_secrets" {
    for_each = var.image_pull_secrets
    iterator = ips
    content {
      registry_endpoint = ips.value.registry_endpoint
      secret_type       = ips.value.secret_type
      password          = ips.value.password
      secret_id         = ips.value.secret_id
      username          = ips.value.username
    }
  }
  dynamic "volumes" {
    for_each = var.volumes
    iterator = vol
    content {
      name          = vol.value.name
      volume_type   = vol.value.volume_type
      backing_store = vol.value.backing_store
      dynamic "configs" {
        for_each = vol.value.configs
        iterator = cfg
        content {
          data      = cfg.value.data
          file_name = cfg.value.file_name
          path      = cfg.value.path
        }
      }
    }
  }
  state = var.state
}
