package setup_test

import (
	"errors"
	"testing"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/setup"
)

type mockCommands struct {
	envErr,
	readLinkErr,
	symlinkErr bool
}

func (m *mockCommands) Getenv(key string) string {
	if m.envErr {
		return ""
	}
	return "/go/path"
}

func (m *mockCommands) Readlink(name string) (string, error) {
	if m.readLinkErr {
		return "", errors.New("error reading symlink")
	}
	return "", nil
}

func (m *mockCommands) Symlink(oldname, newname string) error {
	if m.symlinkErr {
		return errors.New("error creating symlink")
	}
	return nil
}

func TestSetupRun(t *testing.T) {
	files := make(config.Files)
	files["some.file"] = "/path/to/some.file"

	t.Run("TestSuccess", func(t *testing.T) {
		s := setup.New(&mockCommands{false, true, false})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})

	t.Run("TestInvalidGoPathError", func(t *testing.T) {
		s := setup.New(&mockCommands{true, false, false})
		err := s.Run(files)
		if err == nil {
			t.Error("expected error getting $GOPATH, got: nil")
		}
	})

	t.Run("TestRunLinksExist", func(t *testing.T) {
		s := setup.New(&mockCommands{})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})

	t.Run("TestRunSymlinkError", func(t *testing.T) {
		s := setup.New(&mockCommands{false, true, true})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})
}
