package handlers

import (
	"encoding/json"
	"net/http"
)

func Status(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	json.NewEncoder(w).Encode(map[string]interface{}{
		"platform": "TITAN",
		"phase": "Phase 3",
		"status": "operational",
	})
}