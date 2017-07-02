package main

import (
	"errors"
	"testing"
)

type mockCommands struct {
	GetenvFunc   func(key string) string
	ReadlinkFunc func(name string) (string, error)
	SymlinkFunc  func(oldname, newname string) error
}

func (m mockCommands) Getenv(key string) string {
	return m.GetenvFunc(key)
}

func (m mockCommands) Readlink(name string) (string, error) {
	return m.ReadlinkFunc(name)
}

func (m mockCommands) Symlink(oldname, newname string) error {
	return m.SymlinkFunc(oldname, newname)
}

func TestSetupRun(t *testing.T) {
	cmds := mockCommands{}
	files := Dotfiles{
		"some.file": "/path/to/some.file",
	}

	t.Run("TestInvalidGoPathError", func(t *testing.T) {
		cmds.GetenvFunc = func(string) string {
			return ""
		}
		s := NewSetup(cmds)
		err := s.Run(files)
		if err == nil {
			t.Error("expected error getting $GOPATH, got: nil")
		}
	})

	t.Run("TestRunLinksExist", func(t *testing.T) {
		cmds.GetenvFunc = func(string) string {
			return "/usr/go"
		}
		cmds.ReadlinkFunc = func(string) (string, error) {
			return "", nil
		}
		s := NewSetup(cmds)
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})

	t.Run("TestRunSymlinkError", func(t *testing.T) {
		cmds.GetenvFunc = func(string) string {
			return "/usr/go"
		}
		cmds.ReadlinkFunc = func(string) (string, error) {
			return "", errors.New("symlink exists")
		}
		cmds.SymlinkFunc = func(string, string) error {
			return errors.New("error creating symlink")
		}
		s := NewSetup(cmds)
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})

	t.Run("TestSuccess", func(t *testing.T) {
		cmds.GetenvFunc = func(string) string {
			return "/usr/go"
		}
		cmds.ReadlinkFunc = func(string) (string, error) {
			return "", errors.New("symlink exists")
		}
		cmds.SymlinkFunc = func(string, string) error {
			return nil
		}
		s := NewSetup(cmds)
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})
}
