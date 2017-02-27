.PHONY: import export list-dotfiles
SHELL := /bin/bash

DOTFILES := {.bash_logout,.bash_profile,.bashrc,.editorconfig,.gitconfig,.gitignore_global,.tmux.conf,.vimrc}

import:
	@cp ~/$(DOTFILES) $(CURDIR)/dotfiles
	@echo "Imported the following files:"
	@ls ~/$(DOTFILES)

export:
	@cp ~/$(DOTFILES) $(CURDIR)/dotfiles
	@echo "Exported the following files:"
	@ls $(CURDIR)/dotfiles

list-dotfiles:
	@echo "Dotfiles to be considered are:"
	@ls ~/$(DOTFILES)
