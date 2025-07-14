data "oci_identity_availability_domains" "these" {
  compartment_id = var.compartment_id
}

locals {
  ads = data.oci_identity_availability_domains.these.availability_domains
}

resource "oci_container_instances_container_instance" "this" {
  availability_domain = local.ads[var.availability_domain - 1].name
  compartment_id      = var.compartment_id
  dynamic "containers" {
    for_each = var.containers
    content {
      image_url                      = containers.value.image_url
      arguments                      = containers.value.arguments
      command                        = containers.value.command
      defined_tags                   = var.defined_tags
      display_name                   = containers.value.display_name
      is_resource_principal_disabled = containers.value.is_resource_principal_disabled
      environment_variables          = containers.value.environment_variables
      freeform_tags                  = var.freeform_tags
      dynamic "resource_config" {
	for_each = containers.value.resource_config[*]
	iterator = rc
	content {
	  memory_limit_in_gbs = rc.value.memory_limit_in_gbs
	  vcpus_limit         = rc.value.vcpus_limit
	}
      }
      dynamic "volume_mounts" {
	for_each = containers.value.volume_mounts[*]
	content {
	  mount_path   = volume_mounts.value.mount_path
	  volume_name  = volume_mounts.value.volume_name
	  is_read_only = volume_mounts.value.is_read_only
	  partition    = volume_mounts.value.partition
	  sub_path     = volume_mounts.value.sub_path
	}
      }
      working_directory = containers.value.working_directory
    }
  }
  state = var.state
  shape = var.shape
  shape_config {
    ocpus         = var.shape_config.ocpus
    memory_in_gbs = var.shape_config.memory_in_gbs
  }
  vnics {
    subnet_id              = var.subnet_ids[var.vnics.subnet_name]
    defined_tags           = var.vnics.defined_tags
    display_name           = var.vnics.display_name
    freeform_tags          = var.vnics.freeform_tags
    hostname_label         = var.vnics.hostname_label
    is_public_ip_assigned  = var.vnics.is_public_ip_assigned
    nsg_ids                = var.vnics.nsg_ids
    private_ip             = var.vnics.private_ip
    skip_source_dest_check = var.vnics.skip_source_dest_check
  }
  container_restart_policy = var.container_restart_policy
  defined_tags             = var.defined_tags
  display_name             = var.display_name
  dns_config {
    nameservers = var.dns_config.nameservers
    options     = var.dns_config.options
    searches    = var.dns_config.searches
  }
  fault_domain                         = format("FAULT-DOMAIN-%s", var.fault_domain)
  graceful_shutdown_timeout_in_seconds = var.graceful_shutdown_timeout_in_seconds
  dynamic "image_pull_secrets" {
    for_each = var.image_pull_secrets[*]
    content {
      registry_endpoint = var.image_pull_secrets.registry_endpoint
      secret_type       = var.image_pull_secrets.secret_type
      password          = var.image_pull_secrets.password
      secret_id         = var.image_pull_secrets.secret_id
      username          = var.image_pull_secrets.username
    }
  }
  dynamic "volumes" {
    for_each = var.volumes[*]
    content {
      name          = volumes.key
      volume_type   = volumes.value.volume_type
      backing_store = volumes.value.backing_store
      dynamic "configs" {
	for_each = volumes.value.configs[*]
	content {
	  file_name = configs.value.file_name
	  data      = base64encode(file(configs.value.data))
	  path      = configs.value.path
	}
      }
    }
  }
}
