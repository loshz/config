package main

import "os"

// OSCommands defines the interface for the required file linking functions.
type OSCommands interface {
	Getenv(key string) string
	Readlink(name string) (string, error)
	Symlink(oldname, newname string) error
}

// DefaultCommands defines the default commands used by the application.
var DefaultCommands commands

type commands struct{}

// Getenv retrieves the value of the environment variable named by the key. It returns the value, which will be empty if the variable is not present.
func (c commands) Getenv(key string) string {
	return os.Getenv(key)
}

// Readlink returns the destination of the named symbolic link. If there is an error, it will be of type *PathError.
func (c commands) Readlink(name string) (string, error) {
	return os.Readlink(name)
}

// Symlink creates newname as a symbolic link to oldname. If there is an error, it will be of type *LinkError.
func (c commands) Symlink(oldname, newname string) error {
	return os.Symlink(oldname, newname)
}
