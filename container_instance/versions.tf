terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.101.0"
    }
  }
  required_version = ">= 1.5.7"
}
