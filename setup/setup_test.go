package setup_test

import (
	"errors"
	"testing"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/setup"
)

type mockCommands struct {
	err bool
}

func (m *mockCommands) Run(command string, args ...string) (b []byte, err error) {
	if m.err {
		return b, errors.New("error running command")
	}
	return
}

func TestSetupRun(t *testing.T) {
	files := make(config.Files)
	files["some.file"] = "/path/to/some.file"

	t.Run("TestSuccess", func(t *testing.T) {
		s := setup.New(&mockCommands{})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})

	t.Run("TestRunCommandError", func(t *testing.T) {
		s := setup.New(&mockCommands{true})
		err := s.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})
}
