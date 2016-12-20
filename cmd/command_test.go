package cmd_test

import (
	"testing"

	"github.com/danbondd/dotfiles/cmd"
)

func TestInvalidCommandError(t *testing.T) {
	c := cmd.DefaultCommands
	_, err := c.Run("invalid command")
	if err == nil {
		t.Error("expected error, got: nil")
	}
}

func TestValidCommand(t *testing.T) {
	c := cmd.DefaultCommands
	_, err := c.Run("ls")
	if err != nil {
		t.Errorf("expected nil error, got: %v", err)
	}
}
