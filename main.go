package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	var configFile string
	flag.StringVar(&configFile, "config", "config.json", "/path/to/config.json")
	flag.Parse()

	files, err := ReadConfig(configFile)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error reading config file: %v", err)
		os.Exit(-1)
	}

	s := NewSetup(DefaultCommands)
	err = s.Run(files)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error installing config files: %v", err)
		os.Exit(-1)
	}
}
