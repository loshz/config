package cmd

import "os"

// LinkCommands defines the interface for the required file linking functions.
type LinkCommands interface {
	Readlink(name string) (string, error)
	Symlink(oldname, newname string) error
}

// DefaultCommands defines the default commands used by the application.
var DefaultCommands commands

// Commands contains a custom implementation of the Run func.
type commands struct{}

// Readlink returns the destination of the named symbolic link. If there is an error, it will be of type *PathError.
func (c commands) Readlink(name string) (string, error) {
	link, err := os.Readlink(name)
	return link, err
}

// Symlink creates newname as a symbolic link to oldname. If there is an error, it will be of type *LinkError.
func (c commands) Symlink(oldname, newname string) error {
	err := os.Symlink(oldname, newname)
	return err
}
