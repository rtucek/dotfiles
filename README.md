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

- 1password
- bash-completion
- bat
- ctags
- diff-so-fancy
- docker
- docker-compose
- firefox
- fwupd
- git-delta
- gzip
- i3-battery-popup-git
- i3-scrot
- lastpass-cli
- mailspring
- msr-tools
- neovim
- pavucontrol
- percona-server & percona-server-clients (mysql)
- polybar
- postgresql-client
- postman-bin
- pulseaudio-bluetooth
- python-pip
- python2-pip
- rofi
- snapd
- terminator
- testssl.sh
- the_silver_searcher
- thunderbird
- unimatrix-git
- unzip
- xclip
- xss-lock


### Fonts

- ttf-dejavu
- ttf-font-awesome
- ttf-joypixels


### AUR

- certigo
- google-chrome
- nvm
- tmuxinator
- xidlehook (screensaver)


### Snap packages

n/a


### Composer

- `composer global require consolidation/cgr`


### nvm

- Install npm via `nvm install-latest-npm`


### npm

- Install yarn via npm. Let yarn manage itself by re-installing yarn and
  removing it afterwards via npm again.
  `npm -g install yarn; yarn global add yarn; npm -g remove yarn`


### yarn

- @vue/cli
- neovim


### PIP

- `pip install --user --upgrade mycli`
- `pip install --user --upgrade pgcli`
- `pip install --user --upgrade python-language-server` (coc-python)
- `pip2 install --user --upgrade pynvim` (neovim python provider)
- `pip3 install --user --upgrade pynvim` (neovim python provider)


### Bash completion

- composer (`cgr require bamarni/symfony-console-autocomplete`)
- tmux (https://github.com/imomaliev/tmux-bash-completion/blob/master/completions/tmux)
- tmuxinator (https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.bash)
- yarn (https://github.com/dsifford/yarn-completion/blob/master/yarn-completion.bash)
