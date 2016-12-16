package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/helpers"
	"github.com/danbondd/dotfiles/setup"
)

func main() {
	var configFile string
	flag.StringVar(&configFile, "config", "config.json", "/path/to/config.json")
	flag.Parse()

	files, err := config.New(helpers.FileReader, helpers.JSONDecoder, configFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error reading config file: %v", err)
		return
	}

	err = setup.Run(files)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error installing config files: %v", err)
		return
	}
}
