resource "oci_identity_network_source" "identity_network_sources" {
  for_each = var.identity_network_sources

  compartment_id     = each.value.compartment_id
  description        = each.value.description
  name               = each.value.name
  defined_tags       = each.value.defined_tags
  freeform_tags      = each.value.freeform_tags
  public_source_list = each.value.public_source_list
  services           = each.value.services

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "virtual_source_list" {
    for_each = each.value.virtual_source_list != null ? each.value.virtual_source_list : []
    content {
      ip_ranges = virtual_source_list.value.ip_ranges
      vcn_id    = virtual_source_list.value.vcn_id
    }
  }
}

