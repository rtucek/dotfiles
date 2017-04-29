.PHONY: import export list-dotfiles
SHELL := /bin/bash

DOTFILES := {.bash_logout,.bash_profile,.bashrc,.editorconfig,.gitconfig,.gitignore_global,.tmux.conf,.vimrc,.bash_prompt,.path,.exports,.misc,.ctags}

import:
	@echo "Imported the following files:"
	@for dotfile in ~/$(DOTFILES); do \
		if [ -f $$dotfile ]; then \
			cp $$dotfile $(CURDIR)/dotfiles; \
			echo "$$dotfile"; \
		fi \
	done;

export:
	@cp $(CURDIR)/dotfiles/$(DOTFILES) ~
	@echo "Exported the following files to $$HOME:"
	@ls $(CURDIR)/dotfiles/$(DOTFILES)

list-dotfiles:
	@echo "Dotfiles to be considered are:"
	@for dotfile in ~/$(DOTFILES); do \
		if [ -f $$dotfile ]; then \
			echo "$$dotfile"; \
		fi \
	done;
