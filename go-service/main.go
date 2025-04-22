package main

import (
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", getHello)
	err := http.ListenAndServe(":8080", nil)
	if errors.Is(err, http.ErrServerClosed) {
		fmt.Println("server closed")
	} else if err != nil {
		fmt.Printf("error starting server: %s\n", err)
		os.Exit(1)
	}
}

func getHello(w http.ResponseWriter, r *http.Request) {
	name := r.URL.Query().Get("name")
	if name == "" {
		name = "Guest"
	}

	appName := os.Getenv("APP_NAME")
	testEnv := os.Getenv("TEST_ENV")

	missing := ""
	if appName == "" {
		missing += "APP_NAME, "
	}
	if testEnv == "" {
		missing += "TEST_ENV "
	}

	if missing != "" {
		io.WriteString(w, fmt.Sprintf("Missing environment variable(s): %s\n", missing))
		return
	}

	response := fmt.Sprintf("Hello %s from %s (%s)\n", name, appName, testEnv)
	io.WriteString(w, response)
}
