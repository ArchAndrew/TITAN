package main

import (
	"log"
	"net/http"
	"strings"

	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/config"
	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/handlers"
)

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/healthz", handlers.Health)
	mux.HandleFunc("/api/v1/status", handlers.Status)
	mux.HandleFunc("/api/v1/requests/environment", handlers.CreateEnvironmentRequest)

	mux.HandleFunc("/api/v1/requests/", func(w http.ResponseWriter, r *http.Request) {
		if strings.HasSuffix(r.URL.Path, "/status") {
			handlers.UpdateRequestStatus(w, r)
			return
		}

		handlers.GetRequestByID(w, r)
	})

	log.Printf("TITAN Platform API listening on %s", config.LocalAPIAddr)
	if err := http.ListenAndServe(config.LocalAPIAddr, mux); err != nil {
		log.Fatal(err)
	}
}
