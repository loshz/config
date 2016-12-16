package setup

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/danbondd/dotfiles/config"
	"github.com/danbondd/dotfiles/helpers"
)

func Run(configFile string) error {
	goPath := os.Getenv("GOPATH")
	if len(goPath) == 0 {
		return errors.New("error getting $GOPATH env variable")
	}

	files, err := config.New(helpers.FileReader, helpers.JSONDecoder, configFile)
	if err != nil {
		return err
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
