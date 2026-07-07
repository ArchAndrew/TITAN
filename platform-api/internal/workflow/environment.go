package workflow

import (
	"fmt"
	"time"

	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/models"
	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/store"
	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/terraform"
)

func ProcessEnvironmentRequest(req models.EnvironmentRequest) map[string]interface{} {
	requestID := fmt.Sprintf("env-%s", time.Now().UTC().Format("20060102-150405"))

	plan := terraform.PrepareEnvironmentPlan(req)

	response := map[string]interface{}{
		"requestId": requestID,
		"status":    "accepted",
		"workflow":  "environment-provisioning",
		"stage":     "terraform-plan",
		"request":   req,
		"terraform": plan,
		"nextStep":  "policy-validation-approval-and-gitops-workflow",
	}

	if err := store.SaveRequest(requestID, response); err != nil {
		response["status"] = "accepted-with-persistence-warning"
		response["warning"] = err.Error()
	}

	return response
}
