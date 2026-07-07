package store

import (
	"encoding/json"
	"os"
	"path/filepath"
)

const RequestDir = "data/requests"

func SaveRequest(requestID string, payload interface{}) error {
	if err := os.MkdirAll(RequestDir, 0755); err != nil {
		return err
	}

	path := filepath.Join(RequestDir, requestID+".json")

	data, err := json.MarshalIndent(payload, "", "  ")
	if err != nil {
		return err
	}

	return os.WriteFile(path, data, 0644)
}

func GetRequest(requestID string) ([]byte, error) {
	path := filepath.Join(RequestDir, requestID+".json")
	return os.ReadFile(path)
}
