package api

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type Error struct {
	Message string `json:"message"`
}

type ApiResource struct {
	Data   interface{} `json:"data,omitempty"`
	Errors []Error     `json:"errors,omitempty"`
}

func ResourceHandler(resource interface{}, w http.ResponseWriter, r *http.Request) {
	output := ApiResource{Data: resource}

	w.Header().Set("Content-Type", "application/json")
	b, err := json.Marshal(output)
	if err != nil {
		w.WriteHeader(500)
		fmt.Fprintf(w, "{\"errors\":[{\"message\":\"Internal Error\"}]}")
	} else {
		w.Write(b)
	}
}
