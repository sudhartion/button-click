package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type ClickRegisterRequest struct {
	OffsetX int `json:"offsetX"`
	OffsetY int `json:"offsetY"`
}

func handleClickRegister(w http.ResponseWriter, req *http.Request) {
	var body ClickRegisterRequest
	bodyBytes, err := io.ReadAll(req.Body)
	if err != nil {
		fmt.Printf("Response read error: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		fmt.Fprintf(w, "Response read error: %v", err)
		return
	}
	err = json.Unmarshal(bodyBytes, &body)
	if err != nil {
		fmt.Printf("Invalid JSON\n")
		w.WriteHeader(http.StatusBadRequest)
		fmt.Fprintf(w, "Invalid JSON\n")
	} else {
		fmt.Printf("Offset = (%v, %v)\n", body.OffsetX, body.OffsetY)
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "Button Clicked!\n")
	}
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

	host, port := "localhost", 3000
	fmt.Printf("Listening over %v on %v\n", host, port)
	http.ListenAndServe(fmt.Sprintf("%s:%d", host, port), r)
}
