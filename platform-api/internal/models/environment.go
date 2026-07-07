package models

type EnvironmentRequest struct {
	ProjectName string `json:"project_name"`
	Environment string `json:"environment"`
	Owner       string `json:"owner"`
	CostCenter  string `json:"cost_center"`
	Region      string `json:"region"`
}
