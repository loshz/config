# dotfiles [![Build Status](https://travis-ci.org/danbondd/dotfiles.svg?branch=master)](https://travis-ci.org/danbondd/dotfiles)

A simple tool to help setup config files for my personal development environment.

## Installation

- Download source code `go get github.com/danbondd/dotfiles`
- Navigate to project `cd $GOPATH/src/github.com/danbondd/dotfiles`
- Run `make setup`
- Add relevant paths to `config.json`
- Go! `make run` (add optional `-config` flag to point to a config file in another location)

## Config

The config file contains the key value pairs of the config files and the destination they should be symlinked to (paths must be absolute).

```
{
	"nvim": "/path/to/init.vim",
	"zsh": "/path/to/.zshrc",
	"git": "/path/to/.gitconfig"
}
```
