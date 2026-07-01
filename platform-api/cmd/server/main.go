package main

import (
	"log"
	"net/http"

	"github.com/ArchAndrew/Self-Service-Platform/platform-api/internal/handlers"
)

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/healthz", handlers.Health)
	mux.HandleFunc("/api/v1/status", handlers.Status)
	mux.HandleFunc("/api/v1/requests/environment", handlers.CreateEnvironmentRequest)

	log.Println("TITAN Platform API listening on :8081")
	if err := http.ListenAndServe(":8081", mux); err != nil {
		log.Fatal(err)
	}
}
