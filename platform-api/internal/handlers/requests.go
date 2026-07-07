package handlers

import (
	"net/http"
	"strings"

	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/store"
)

func GetRequestByID(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}

	requestID := strings.TrimPrefix(r.URL.Path, "/api/v1/requests/")
	if requestID == "" {
		http.Error(w, "missing request ID", http.StatusBadRequest)
		return
	}

	data, err := store.GetRequest(requestID)
	if err != nil {
		http.Error(w, "request not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(data)
}
