package config

import (
	"fmt"
	"io"

	"github.com/danbondd/dotfiles/helpers"
)

// Files contains the key value pairs of the config files and their symlink destinations.
type Files map[string]string

type openFile func(name string) (io.ReadCloser, error)

type decodeData func(r io.Reader) helpers.Decoder

// New creates a new Config from the given fields in config.json
func New(open openFile, d decodeData, configFile string) (Files, error) {
	files := make(Files)

	file, err := open(configFile)
	if err != nil {
		return nil, fmt.Errorf("error opening config file: %v", err)
	}
	defer file.Close()

	decoder := d(file)
	if err := decoder.Decode(&files); err != nil {
		return nil, fmt.Errorf("error decoding config JSON: %v", err)
	}

	return files, nil
}
