package users

import (
	"log"
	"net/http"

	"code.google.com/p/go-uuid/uuid"

	"github.com/snocorp/jurny/api"
)

type User struct {
	ID   string `json:"id"`
	Type string `json:"type"`
}

func newUser(id string) User {
	u := User{id, "user"}

	return u
}

// NewUserHandler creates a new user
func NewUserHandler(w http.ResponseWriter, r *http.Request) {

	email := r.FormValue("email")
	password := r.FormValue("password")

	log.Println(email)
	log.Println(password)

	api.ResourceHandler(newUser(uuid.New()), w, r)
}
