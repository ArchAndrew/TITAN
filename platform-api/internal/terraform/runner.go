package terraform

import (
	"fmt"

	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/models"
)

type PlanResult struct {
	Mode    string `json:"mode"`
	Command string `json:"command"`
	Message string `json:"message"`
}

func PrepareEnvironmentPlan(req models.EnvironmentRequest) PlanResult {
	command := fmt.Sprintf(
		"terragrunt run-all plan --terragrunt-working-dir ../live/dev/%s",
		req.Region,
	)

	return PlanResult{
		Mode:    "plan-only",
		Command: command,
		Message: "Terraform plan prepared; apply requires approval workflow",
	}
}
