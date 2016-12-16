package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/danbondd/dotfiles/setup"
)

func main() {
	var configFile string
	flag.StringVar(&configFile, "config", "config.json", "/path/to/config.json")
	flag.Parse()

	err := setup.Run(configFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error installing config files: %v", err)
		return
	}
}
