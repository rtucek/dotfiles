# Dotfiles

My dotfiles - use them and contribute your personal changes/suggestions.
The `setup` script requires Python 3.


## Installation (export)

Copy all files over the current existing ones (this will effectively overwrite
any current settings).

```
./setup export
```


## Publish settings (import)

Copies a list of files into the current workspace, ready for committing.

```
./setup import
```


## Contribution

Pull requests are welcome!


## Dependencies

The dotfiles are optimized for the following setup.


### General packages

- bash-completion
- bat
- ctags
- diff-so-fancy
- docker
- docker-compose
- firefox
- gzip
- i3-scrot
- msr-tools
- neovim
- nodejs
- npm
- pavucontrol
- polybar
- postgresql-client
- pulseaudio-bluetooth
- python-pip
- python2-pip
- rofi
- snapd
- terminator
- the_silver_searcher
- unzip
- xclip
- xss-lock
- yarn


### Fonts

- ttf-dejavu
- ttf-font-awesome
- ttf-joypixels


### AUR

- google-chrome
- tmuxinator
- xidlehook


### AUR build

- mysql-clients (with patch from https://pastebin.com/wtVwRgFt)


### Snap packages

- mailspring


### Composer

- `composer global require consolidation/cgr`


### PIP

- `pip install --user --upgrade mycli`
- `pip install --user --upgrade pgcli`
- `pip install --user --upgrade python-language-server` (coc-python)
- `pip2 install --user --upgrade pynvim` neovim python provider
- `pip3 install --user --upgrade pynvim` neovim python provider
- `sudo pip install --upgrade ranger-fm`


### Bash completion

- composer (`cgr require bamarni/symfony-console-autocomplete`)
- tmux (https://github.com/imomaliev/tmux-bash-completion/blob/master/completions/tmux)
- tmuxinator (https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.bash)
- yarn (https://github.com/dsifford/yarn-completion/blob/master/yarn-completion.bash)
