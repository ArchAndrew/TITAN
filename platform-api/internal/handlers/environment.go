package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/models"
	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/workflow"
)

func CreateEnvironmentRequest(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var req models.EnvironmentRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	response := workflow.ProcessEnvironmentRequest(req)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
