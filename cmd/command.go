package cmd

import "os/exec"

// RunCommand defines the interface for the Run function.
type RunCommand interface {
	Run(string, ...string) ([]byte, error)
}

// DefaultCommands defines the default commands used by the application.
var DefaultCommands commands

// Commands contains a custom implementation of the Run func.
type commands struct{}

// Run runs a specified command OS command along with any arguments.
func (c commands) Run(command string, args ...string) ([]byte, error) {
	out, err := exec.Command(command, args...).Output()
	return out, err
}
