package handlers

import (
	"encoding/json"
	"net/http"
	"os"
	"path/filepath"
	"strings"
)

type StatusUpdate struct {
	Status string `json:"status"`
	Stage  string `json:"stage"`
}

func UpdateRequestStatus(w http.ResponseWriter, r *http.Request) {

	if r.Method != http.MethodPatch {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}

	requestID := strings.TrimPrefix(r.URL.Path, "/api/v1/requests/")
	requestID = strings.TrimSuffix(requestID, "/status")

	path := filepath.Join("data/requests", requestID+".json")

	file, err := os.ReadFile(path)
	if err != nil {
		http.Error(w, "request not found", http.StatusNotFound)
		return
	}

	var request map[string]interface{}

	json.Unmarshal(file, &request)

	var update StatusUpdate

	json.NewDecoder(r.Body).Decode(&update)

	request["status"] = update.Status
	request["stage"] = update.Stage

	output, _ := json.MarshalIndent(request, "", "  ")

	os.WriteFile(path, output, 0644)

	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
}
