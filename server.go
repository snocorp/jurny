package main

import (
	"fmt"
	"net/http"

	"github.com/codegangsta/negroni"
	"github.com/gorilla/mux"

	"github.com/snocorp/jurny/users"
)

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/users", users.NewUserHandler).Methods("POST")
	r.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprintf(w, "{\"result\":\"ok\"}")
	})

	n := negroni.Classic()
	n.UseHandler(r)
	n.Run(":3001")
}
