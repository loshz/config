package setup

import (
	"errors"
	"fmt"
	"os"
	"path/filepath"

	"github.com/danbondd/dotfiles/cmd"
	"github.com/danbondd/dotfiles/config"
)

var (
	filesSrc string = "/src/github.com/danbondd/dotfiles/files/"
)

type setup struct {
	cmd cmd.RunCommand
}

// New returns a new setup with a given command interface.
func New(cmd cmd.RunCommand) setup {
	return setup{cmd}
}

type file struct {
	location,
	name string
}

// Run takes the location of a config file, reads it's contents, and creates a symlink for every config file.
func (s setup) Run(files config.Files) error {
	goPath := os.Getenv("GOPATH")
	if len(goPath) == 0 {
		return errors.New("error getting $GOPATH env variable")
	}
	filesSrc = filepath.Join(goPath, filesSrc)

	jobs := make(chan file)
	results := make(chan error)
	for w := 1; w <= 3; w++ {
		go s.worker(jobs, results)
	}

	go func() {
		for name, location := range files {
			jobs <- file{location, name}
		}
		close(jobs)
	}()

	var success int
	for a := 1; a <= len(files); a++ {
		err := <-results
		if err != nil {
			fmt.Fprintf(os.Stderr, "%v\n", err)
			continue
		}
		success++
	}

	fmt.Printf("Successfully copied %d out of %d config files.\n", success, len(files))
	return nil
}

func (s setup) createSymLink(location, file string) error {
	_, err := os.Readlink(filepath.Join(location, file))
	if err == nil {
		return nil
	}

	destination := filepath.Join(filesSrc, file)
	_, err = s.cmd.Run("ln", "-s", destination, location)
	if err != nil {
		return fmt.Errorf("error copying %s config: %v\n", file, err)
	}
	return nil
}

func (s setup) worker(jobs <-chan file, results chan<- error) {
	for f := range jobs {
		results <- s.createSymLink(f.location, f.name)
	}
}
