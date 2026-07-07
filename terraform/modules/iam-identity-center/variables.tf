variable "permission_sets" {
  type = map(object({
    description          = string
    session_duration     = string
    managed_policy_arns  = list(string)
  }))
}

variable "assignments" {
  type = map(object({
    group_name          = string
    permission_set_name = string
    account_id          = string
  }))
}