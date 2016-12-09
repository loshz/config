package setup

import (
	"errors"
	"fmt"
	"os"

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
	if err := fileExists(loc); err != nil {
		return err
	}

	return os.Symlink(loc, fmt.Sprintf("%s/dotfiles/files/%s", goPath, file))
}

func fileExists(path string) error {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		return fmt.Errorf("file does not exist: %s", path)
	}

	return nil
}
