.PHONY: import export list-dotfiles
SHELL := /bin/bash

DOTFILES := {.bash_logout,.bash_profile,.bashrc,.editorconfig,.gitconfig,.gitignore_global,.tmux.conf,.vimrc,.bash_prompt,.path,.exports,.misc}

import:
	@cp ~/$(DOTFILES) $(CURDIR)/dotfiles
	@echo "Imported the following files:"
	@ls ~/$(DOTFILES)

export:
	@cp $(CURDIR)/dotfiles/$(DOTFILES) ~
	@echo "Exported the following files to $$HOME:"
	@ls $(CURDIR)/dotfiles/$(DOTFILES)

list-dotfiles:
	@echo "Dotfiles to be considered are:"
	@ls ~/$(DOTFILES)
