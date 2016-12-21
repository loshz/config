package setup_test

import (
	"errors"
	"testing"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/setup"
)

type mockCommands struct {
	readLinkErr,
	symlinkErr bool
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
		s := setup.New(&mockCommands{true, false})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
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
		s := setup.New(&mockCommands{true, true})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})
}
