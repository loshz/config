package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
)

const configFile string = "/.dotfiles/config.json"

type openFile func(name string) (io.ReadCloser, error)

// fileReader opens the named file for reading.
func fileReader(name string) (io.ReadCloser, error) {
	return os.Open(name)
}

type config map[string]string

// decoder specifies the behaviour of a given decoder.
// It only implements the Decode method which reads the next JSON-encoded
// value from its input and stores it in the value pointed to by v.
type decoder interface {
	Decode(v interface{}) error
}

type decoderFactory func(r io.Reader) decoder

// newJSONDecoder returns a new JSON Decoder.
func newJSONDecoder(r io.Reader) decoder {
	return json.NewDecoder(r)
}

// newConfig creates a new Config from the given fields in config.json
func newConfig(open openFile, d decoderFactory, homeDir string) (config, error) {
	c := make(config)

	file, err := open(fmt.Sprintf("%s%s", homeDir, configFile))
	if err != nil {
		return nil, fmt.Errorf("error opening config file: %v", err)
	}
	defer file.Close()

	decoder := d(file)
	if err := decoder.Decode(&c); err != nil {
		return nil, fmt.Errorf("error decoding config JSON: %v", err)
	}

	return c, nil
}
