output "id" {
  description = "An OCID that cannot be changed."
  value       = oci_container_instances_container_instance.this.id
}

output "availability_domain" {
  description = "The availability domain to place the container instance."
  value       = oci_container_instances_container_instance.this.availability_domain
}

output "compartment_id" {
  description = "The OCID of the compartment."
  value       = oci_container_instances_container_instance.this.compartment_id
}

output "container_count" {
  description = "The number of containers on the container instance."
  value       = oci_container_instances_container_instance.this.container_count
}

output "container_restart_policy" {
  description = "The container restart policy is applied for all containers in container instance."
  value       = oci_container_instances_container_instance.this.container_restart_policy
}

output "containers" {
  description = "The containers on the container instance."
  value       = oci_container_instances_container_instance.this.containers
}

output "display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = oci_container_instances_container_instance.this.display_name
}

output "dns_config" {
  description = "DNS settings for containers."
  value       = oci_container_instances_container_instance.this.dns_config
}

output "fault_domain" {
  description = "The fault domain to place the container instance."
  value       = oci_container_instances_container_instance.this.fault_domain
}

output "graceful_shutdown_timeout_in_seconds" {
  description = "The amount of time that processes in a container have to gracefully end when the container must be stopped. For example, when you delete a container instance. After the timeout is reached, the processes are sent a signal to be deleted."
  value       = oci_container_instances_container_instance.this.graceful_shutdown_timeout_in_seconds
}

output "image_pull_secrets" {
  description = "The image pulls secrets so you can access private registry to pull container images."
  value       = oci_container_instances_container_instance.this.image_pull_secrets
}

output "lifecycle_details" {
  description = "A message that describes the current state of the container in more detail. Can be used to provide actionable information."
  value       = oci_container_instances_container_instance.this.lifecycle_details
}

output "shape" {
  description = "The shape of the container instance. The shape determines the number of OCPUs, amount of memory, and other resources that are allocated to a container instance."
  value       = oci_container_instances_container_instance.this.shape
}

output "shape_config" {
  description = "The shape configuration for a container instance. The shape configuration determines the resources thats are available to the container instance and its containers."
  value       = oci_container_instances_container_instance.this.shape_config
}

output "state" {
  description = "The current state of the container instance."
  value       = oci_container_instances_container_instance.this.state
}

output "time_created" {
  description = "The time the container instance was created, in the format defined by [RFC 3339](https://tools.ietf.org/rfc/rfc3339)."
  value       = oci_container_instances_container_instance.this.time_created
}

output "time_updated" {
  description = "The time the container instance was updated, in the format defined by [RFC 3339](https://tools.ietf.org/rfc/rfc3339)."
  value       = oci_container_instances_container_instance.this.time_updated
}

output "vnics" {
  description = "The virtual networks available to the containers in the container instance."
  value       = oci_container_instances_container_instance.this.vnics
}

output "volume_count" {
  description = "The number of volumes that are attached to the container instance."
  value       = oci_container_instances_container_instance.this.volume_count
}

output "volumes" {
  description = "A volume is a directory with data that is accessible across multiple containers in a container instance."
  value       = oci_container_instances_container_instance.this.volumes
}
