# Dotfiles

My dotfiles - use them and contribute your personal changes/suggestions.


## Installation

Dotfiles are managed by [chezmoi](https://github.com/twpayne/chezmoi).

A couple of template variables have to be set for proper configuration.
Use the sample config file from `dot_config/chezmoi/chezmoi.toml.sample` and
copy it to `~/.config/chezmoi/chezmoi.toml`, then set the value accordingly and
run `chezmoi apply` for having the actual dotfiles being put a their right
place.

Refer to [chezmoi's docs](https://www.chezmoi.io/) for further details.


## Contribution

Pull requests are welcome!


## Dependencies

The dotfiles are optimized for the following setup.


### General packages

- arch-audit
- bash-completion
- bat [1]
- chezmoi
- ctags
- diff-so-fancy
- docker
- docker-compose
- firefox
- fwupd
- git-delta [1]
- gnome-keyring
- go
- gzip
- i3-battery-popup-git
- i3-scrot
- kubectl
- lastpass-cli
- mkcert
- msr-tools
- neovim
- osquery
- pavucontrol
- percona-server & percona-server-clients (mysql)
- picom
- pigz
- polybar
- postgresql-client
- pulseaudio-bluetooth
- python-pip
- rofi
- snapd
- terminator
- testssl.sh
- the_silver_searcher
- thunderbird
- unzip
- xclip
- xss-lock

> As a special case, in order to have syntax highlighting for PHP work with
> `bat` in combination with `delta` diffs, refer to [these
> instructions](https://github.com/dandavison/delta/issues/162#issuecomment-625952288).
>
> It's necessary to perform this step, whenever `bat` gets updated.


### Fonts

- ttf-dejavu
- ttf-font-awesome
- ttf-joypixels


### AUR

- certigo
- google-chrome
- kind-bin
- nvm
- postman-bin
- tmuxinator
- unimatrix-git
- xidlehook (screensaver)


### Snap packages

n/a


### Composer

- `composer global require consolidation/cgr`


### nvm

Most important commands are:

- Installing most recent LTS version
  `nvm install --lts`
- Alias most recent node version as default
  `nvm alias default node`
- Use most recent version
  `nvm use default`
- Upgrade npm to the latest version
  `nvm install-latest-npm`


### npm

The following npm packages are considered as standard.
Install them via `npm install --global [packages]`:

- @vue/cli
- create-react-app
- neovim


### yarn

Install yarn via npm. Let yarn manage itself by re-installing yarn globally and
removing it afterwards via npm again.

```
npm -g install yarn
yarn global add yarn
npm -g remove yarn
```


### PIP

- `pip install --user --upgrade mycli`
- `pip install --user --upgrade pgcli`
- `pip install --user --upgrade python-language-server` (coc-python)
- `pip install --user --upgrade pynvim` (neovim python provider)


### Bash completion

- composer (`cgr require bamarni/symfony-console-autocomplete`)
- tmux (https://github.com/imomaliev/tmux-bash-completion/blob/master/completions/tmux)
- tmuxinator (https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.bash)
- yarn (https://github.com/dsifford/yarn-completion/blob/master/yarn-completion.bash)


## CPU clock modulation fix

Dell XPS devices may become slow after system wakeups. This is due to aggressive
[suspend settings in clock modulation
settings](https://wiki.archlinux.org/title/Dell_XPS_13_2-in-1_(7390)#Sleep/Suspend_causes_slow_system).

To fix this issue, add the systemd unit file to
`/etc/systemd/system/msr-fix.service`, then enable it via
`sudo systemctl enaled msr-fix.service`. The unit file will explicitly reset the
necessary CPU register.

```
[Unit]
Description=Fix MSR after wakeup
After=suspend.target

[Service]
User=root
Type=oneshot
ExecStart=wrmsr -a 0x19a 0x0

[Install]
WantedBy=suspend.target
```
