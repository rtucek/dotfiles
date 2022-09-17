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
- bat [[1]](#[1]-syntax-highlight-with-bat-and-cat)
- chezmoi
- ctags
- diff-so-fancy
- docker [[2]](#[2]-docker-post-installation)
- docker-compose
- firefox
- fwupd
- git-delta [[1]](#[1]-syntax-highlight-with-bat-and-cat)
- gnome-keyring
- go
- gzip
- i3-battery-popup-git
- i3-scrot
- kubectl
- lastpass-cli
- mkcert
- msr-tools
- mysql-workbench 
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
- tmux [[3](#[3]-install-tmux-plugins)]
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
- kind-bin
- nvm
- postman-bin
- tmuxinator
- unimatrix-git
- xidlehook (screensaver)


### Snap packages

n/a


### Composer

```bash
composer global require consolidation/cgr
```


### nvm

Most important commands are:

```bash
nvm install --lts # Installing most recent LTS version
nvm alias default node # Alias most recent node version as default
nvm use default # Use most recent version
nvm install-latest-npm # Upgrade npm to the latest version
```


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

```bash
pip install --user --upgrade mycli
pip install --user --upgrade pgcli`
pip install --user --upgrade python-language-server # (coc-python)
pip install --user --upgrade pynvim # (neovim python provider)
```


### Bash completion

- composer (`cgr require bamarni/symfony-console-autocomplete`)
- tmux (https://github.com/imomaliev/tmux-bash-completion/blob/master/completions/tmux)
- tmuxinator (https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.bash)
- yarn (https://github.com/dsifford/yarn-completion/blob/master/yarn-completion.bash)


## Addendum

### [1] Syntax highlight with bat and cat

As a special case, in order to have syntax highlighting for PHP work with
`bat` in combination with `delta` diffs, refer to [these
instructions](https://github.com/dandavison/delta/issues/162#issuecomment-625952288).

It's necessary to perform this step, whenever `bat` gets updated.


### [2] Docker post-installation

By default, the docker installation requires some manual actions. For instance,
the docker daemon is not started automatically. It's required to run `sudo
systemctl start docker` after the installation and likewise, it's required to
run every docker command with sudo. For convenience, you'd typically want to run
these commands once ([based on Docker's official
docs](https://docs.docker.com/engine/install/linux-postinstall/):

```bash
# Start docker and containerd daemon upon boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Run docker commands root-less
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```


### [3] Install tmux plugins

After tmux has been installed, run the following commands in order to install
and setup tmux plugin manager ([TPM](https://github.com/tmux-plugins/tpm)) for
the first time. The following commands below will clone TPM's source code and
install it at the right location, then type; `Ctrl + SPACE + I` in order to
actually install tmux plugins.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```


### sudo password indicator

When using `sudo`, it's convenient to have a masked password indicator in case
sudo requires to enter the user's password. In order to have a password
indicator, simply run `sudo visudo` and add the following lines below.

```diff
# Have a masked password indicator, when typing the password for sudo
Defaults pwfeedback
```


### CPU clock modulation fix

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
