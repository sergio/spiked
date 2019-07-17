package main

import (
	"fmt"
	"log"
	"net/http"
	"runtime"
	"strings"
)

var version = "1.0.0"

func sayHello(w http.ResponseWriter, r *http.Request) {
	message := r.URL.Path
	message = strings.TrimPrefix(message, "/")
	message = "Hello " + message
	log.Printf("Just received: %s\n", message)
	if message[0] == 'x' {
		panic(fmt.Errorf("Unexpected death"))
	}
	w.Write([]byte(message))

}

func main() {
	log.Printf("Spiked service - Version %s (%s,%s)\n", version, runtime.GOOS, runtime.GOARCH)
	http.HandleFunc("/", sayHello)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
