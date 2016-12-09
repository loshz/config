NAME = dotfiles

build:
	go build -o $(NAME)

run: build
	./$(NAME)

setup:
	cp config.json.example config.json

test:
	go test ./... -race -cover
