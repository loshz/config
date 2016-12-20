package setup

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"

	"github.com/danbondd/dotfiles/cmd"
	"github.com/danbondd/dotfiles/config"
)

type setup struct {
	cmd cmd.RunCommand
}

// New returns a new setup with a given command interface.
func New(cmd cmd.RunCommand) setup {
	return setup{cmd}
}

// Run takes the location of a config file, reads it's contents, and creates a symlink for every config file.
func (s setup) Run(files config.Files) error {
	goPath := os.Getenv("GOPATH")
	if len(goPath) == 0 {
		return errors.New("error getting $GOPATH env variable")
	}

	var success int
	for file, loc := range files {
		if err := s.createSymLink(loc, file, goPath); err != nil {
			fmt.Fprintf(os.Stderr, "error copying %s config: %v\n", file, err)
			continue
		}
		success++
	}

	fmt.Printf("Setup complete, %d files copied.\n", success)
	return nil
}

func (s setup) createSymLink(loc, file, goPath string) error {
	_, err := os.Readlink(filepath.Join(loc, file))
	if err == nil {
		return nil
	}

	root := filepath.Join(goPath, "/src/github.com/danbondd/dotfiles/files/", file)
	_, err = s.cmd.Run("ln", "-s", root, loc)
	if err != nil {
		return err
	}
	return nil
}
