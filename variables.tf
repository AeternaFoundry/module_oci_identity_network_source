variable "identity_network_sources" {
  description = <<EOT
Map of identity_network_sources, attributes below
Required:
    - compartment_id
    - description
    - name
Optional:
    - defined_tags
    - freeform_tags
    - public_source_list
    - services
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - virtual_source_list (block):
        - ip_ranges (required)
        - vcn_id (required)
EOT

  type = map(object({
    compartment_id     = string
    description        = string
    name               = string
    defined_tags       = optional(map(string))
    freeform_tags      = optional(map(string))
    public_source_list = optional(list(string))
    services           = optional(list(string))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    virtual_source_list = optional(list(object({
      ip_ranges = list(string)
      vcn_id    = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.identity_network_sources : (
        v.virtual_source_list == null || (length(v.virtual_source_list) <= 100)
      )
    ])
    error_message = "Each virtual_source_list list must contain at most 100 items"
  }
}

