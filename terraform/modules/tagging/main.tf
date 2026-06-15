locals {
  required_tags = {
    Project            = var.project_name
    Environment        = var.environment
    Application        = var.application
    BusinessOwner      = var.business_owner
    TechnicalOwner     = var.technical_owner
    CostCenter         = var.cost_center
    DataClassification = var.data_classification
    ComplianceScope    = var.compliance_scope
    ManagedBy          = var.managed_by
  }

  tags = merge(local.required_tags, var.additional_tags)
}