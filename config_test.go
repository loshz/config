package main

import (
	"bytes"
	"errors"
	"io"
	"io/ioutil"
	"testing"
)

type testDecoder struct {
	r io.Reader
}

func (t testDecoder) Decode(v interface{}) error {
	return errors.New("decode error")
}

func mockDecoder(r io.Reader) decoder {
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
        "ConsumerKey"      : "CONSUMER_KEY",
        "ConsumerSecret"   : "CONSUMER_SECRET",
        "AccessToken"      : "ACCESS_TOKEN",
        "AccessTokenSecret": "ACCESS_TOKEN_SECRET"
    }`)
	return ioutil.NopCloser(bytes.NewReader(b)), nil
}

func TestFileOpenError(t *testing.T) {
	mock := mockFileReader{true}
	_, err := newConfig(mock.mockOpen, newJSONDecoder)
	if err == nil {
		t.Error("expected file open error, got: nil")
	}
}

func TestDecodeError(t *testing.T) {
	mock := mockFileReader{false}
	_, err := newConfig(mock.mockOpen, mockDecoder)
	if err == nil {
		t.Error("expected file decode error, got: nil")
	}
}

func TestConfigSuccess(t *testing.T) {
	mock := mockFileReader{false}
	_, err := newConfig(mock.mockOpen, newJSONDecoder)
	if err != nil {
		t.Errorf("expected nil error, got: %v", err)
	}
}
