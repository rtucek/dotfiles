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

bash-completion
bat
composer
ctags
docker
firefox
gzip
i3-scrot
msr-tools
neovim
nodejs
npm
polybar
postgresql-client
python-pip
python2-pip
rofi
snapd
unzip
xclip
xss-lock
yarn


### Fonts

ttf-dejavu
ttf-font-awesome


### AUR

google-chrome
tmuxinator
xidlehook


### AUR build

mysql-clients (with patch from https://pastebin.com/wtVwRgFt)


### Snap packages

mailspring


### Composer

composer global require consolidation/cgr


### PIP

mycli
pgcli


### Bash completion

composer (cgr require bamarni/symfony-console-autocomplete)
tmux (https://github.com/imomaliev/tmux-bash-completion/blob/master/completions/tmux)
tmuxinator (https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.bash)
yarn (https://github.com/dsifford/yarn-completion/blob/master/yarn-completion.bash)


### Config

Reverse touchpad scrolling ("natural scrolling") - https://forum.manjaro.org/t/reversed-scrolling-in-i3-edition/25811
