package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
)

// Dotfiles contains the key value pairs of the config files and their symlink destinations.
type Dotfiles map[string]string

// ReadConfig reads a config file and returns its contents.
func ReadConfig(filename string) (Dotfiles, error) {
	config := make(Dotfiles)
	file, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, fmt.Errorf("error opening config file: %v", err)
	}
	if err := json.Unmarshal(file, &config); err != nil {
		return nil, fmt.Errorf("error unmarshalling config JSON: %v", err)
	}
	return config, nil
}
