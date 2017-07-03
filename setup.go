package main

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"
)

var filesSrc = "/src/github.com/danbondd/dotfiles/files/"

// Setup is composed of a default set of OS commands.
type Setup struct {
	cmds OSCommands
}

// NewSetup returns a new setup with a given command interface.
func NewSetup(cmds OSCommands) Setup {
	return Setup{
		cmds: cmds,
	}
}

// Run takes the location of a config file, reads it's contents, and creates a symlink for every config file.
func (s Setup) Run(files Dotfiles) (string, error) {
	goPath := s.cmds.Getenv("GOPATH")
	if len(goPath) == 0 {
		return "", errors.New("error getting $GOPATH env variable")
	}
	filesSrc = filepath.Join(goPath, filesSrc)

	var success int
	for file, location := range files {
		err := s.createSymLink(location, file)
		if err != nil {
			fmt.Fprintf(os.Stderr, "%v", err)
			continue
		}
		success++
	}
	return fmt.Sprintf("Successfully copied %d out of %d config files.", success, len(files)), nil
}

func (s Setup) createSymLink(location, file string) error {
	_, err := s.cmds.Readlink(location)
	if err != nil {
		destination := filepath.Join(filesSrc, file)
		err = s.cmds.Symlink(destination, location)
		if err != nil {
			return fmt.Errorf("error copying %s config: %v", file, err)
		}
	}
	return nil
}
