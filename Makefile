default: install

install:
	@mkdir -p ~/.local/bin
	@stow . -t ~

uninstall:
	@stow -D . -t ~
