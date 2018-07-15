#!/bin/bash

DOTFILES=(
	".bash_aliases"			\
	".bash_logout"			\
	".bash_profile"			\
	".bash_prompt"			\
	".bashrc"			\
	".ctags"			\
	".editorconfig"			\
	".exports"			\
	".fzf.bash"			\
	".gitconfig"			\
	".gitignore_global"		\
	".misc"				\
	".notags"			\
	".path"				\
	".selected_editor"		\
	".tmux.conf"			\
	".vimrc"			\
)

SCRIPTPATH="$(cd "$(dirname "$0")"; pwd -P )"

import_dotfiles() {
	echo "Imported the following files:"
	for dotfile in "${DOTFILES[@]}"; do
		if [ -f "${HOME}/${dotfile}" ]; then
			cp "${HOME}/${dotfile}" "${SCRIPTPATH}/dotfiles"
			echo "${HOME}/${dotfile}"
		fi
	done;
}

export_dotfiles() {
	echo "Export the following files:"
	for dotfile in "${DOTFILES[@]}"; do
		cp "${SCRIPTPATH}/dotfiles/${dotfile}" "${HOME}"
		echo "$dotfile"
	done;
}

list_dotfiles() {
	echo "Dotfiles to be considered are:"
	for dotfile in ${DOTFILES[@]}; do
		if [ -f "${HOME}/${dotfile}" ]; then
			echo "${HOME}/${dotfile}";
		fi
	done;
}

case "$1" in
	-i)
		import_dotfiles
		;;
	-e)
		export_dotfiles
		;;
	-l)
		list
		;;
	*)
		echo "Command not found" >&2
		exit 1
esac
