package config_test

import (
	"bytes"
	"errors"
	"io"
	"io/ioutil"
	"testing"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/helpers"
)

const (
	configFile string = "config.json"
)

type testDecoder struct {
	r io.Reader
}

func (t testDecoder) Decode(v interface{}) error {
	return errors.New("decode error")
}

func mockDecoder(r io.Reader) helpers.Decoder {
	return testDecoder{r}
}

type mockFileReader struct {
	readErr bool
}

func (m mockFileReader) mockOpen(name string) (io.ReadCloser, error) {
	if m.readErr {
		return nil, errors.New("file corrupt")
	}

	b := []byte(`{
		"nvim": "/path/to/init.vim",
		"zsh": "/path/to/.zshrc",
		"git": "/path/to/.gitconfig"
	}`)
	return ioutil.NopCloser(bytes.NewReader(b)), nil
}

func TestFileOpenError(t *testing.T) {
	mock := mockFileReader{true}
	_, err := config.New(mock.mockOpen, helpers.JSONDecoder, configFile)
	if err == nil {
		t.Error("expected file open error, got: nil")
	}
}

func TestDecodeError(t *testing.T) {
	mock := mockFileReader{false}
	_, err := config.New(mock.mockOpen, mockDecoder, configFile)
	if err == nil {
		t.Error("expected file decode error, got: nil")
	}
}

func TestConfigSuccess(t *testing.T) {
	mock := mockFileReader{false}
	_, err := config.New(mock.mockOpen, helpers.JSONDecoder, configFile)
	if err != nil {
		t.Errorf("expected nil error, got: %v", err)
	}
}
