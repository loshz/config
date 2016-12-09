package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/danbondd/dotfiles/setup"
)

func main() {
	var configFile string
	flag.StringVar(&configFile, "config", "", "/path/to/config.json")
	flag.Parse()

	if len(configFile) == 0 {
		fmt.Println("Please choose a config file.")
		return
	}

	err := setup.Run(configFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error installing config files: %v", err)
		return
	}
}
