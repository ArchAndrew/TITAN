package handlers

import (
	"encoding/json"
	"net/http"
)

type EnvironmentRequest struct {
	ProjectName string `json:"project_name"`
	Environment string `json:"environment"`
	Owner       string `json:"owner"`
	CostCenter  string `json:"cost_center"`
	Region      string `json:"region"`
}

func CreateEnvironmentRequest(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var req EnvironmentRequest

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	w.Header().Set("Content-Type", "application/json")

	json.NewEncoder(w).Encode(map[string]interface{}{
		"status": "accepted",
		"request": req,
		"nextStep": "Trigger Terraform Workflow",
	})
}