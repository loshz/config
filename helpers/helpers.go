package helpers

import (
	"encoding/json"
	"io"
	"os"
)

// FileReader opens the named file for reading.
func FileReader(name string) (io.ReadCloser, error) {
	return os.Open(name)
}

// Decoder specifies the behaviour of a given decoder.
// It only implements the Decode method which reads the next JSON-encoded
// value from its input and stores it in the value pointed to by v.
type Decoder interface {
	Decode(v interface{}) error
}

// JSONDecoder returns a new JSON Decoder.
func JSONDecoder(r io.Reader) Decoder {
	return json.NewDecoder(r)
}
