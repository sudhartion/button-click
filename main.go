package main

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func handleClickRegister(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "Button clicked!\n")
}

func handleFavicon(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(http.StatusNoContent)
}

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Use(middleware.RedirectSlashes)

	r.HandleFunc("POST /click/register", handleClickRegister)
	r.HandleFunc("GET /favicon.ico", handleFavicon)

	fmt.Println("Listening")
	http.ListenAndServe("localhost:3000", r)
}
