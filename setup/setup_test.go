package setup_test

import (
	"testing"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/setup"
)

func TestSetupRun(t *testing.T) {
	files := make(config.Files)

	t.Run("TestSuccess", func(t *testing.T) {
		err := setup.Run(files)
		if err != nil {
			t.Errorf("expected error: nil, got: %v", err)
		}
	})
}
