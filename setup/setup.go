package setup

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/danbondd/dotfiles/config"
)

// Run takes the location of a config file, reads it's contents, and creates a symlink for every config file.
func Run(files config.Files) error {
	goPath := os.Getenv("GOPATH")
	if len(goPath) == 0 {
		return errors.New("error getting $GOPATH env variable")
	}

	var success int
	for file, loc := range files {
		if err := createSymLink(loc, file, goPath); err != nil {
			fmt.Fprintf(os.Stderr, "error copying %s config: %v\n", file, err)
			continue
		}
		success++
	}

	fmt.Printf("Setup complete, %d files copied.\n", success)
	return nil
}

func createSymLink(loc, file, goPath string) error {
	_, err := os.Readlink(filepath.Join(loc, file))
	if err == nil {
		return nil
	}

	root := filepath.Join(goPath, "/src/github.com/danbondd/dotfiles/files/", file)
	cmd := exec.Command("ln", "-s", root, loc)

	err = cmd.Run()
	if err != nil {
		return err
	}
	return nil
}
