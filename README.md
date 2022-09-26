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
- brightnessctl
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
- jq
- kubectl
- lastpass-cli
- mkcert
- msr-tools
- mysql-workbench
- neovim
- osquery
- pavucontrol
- percona-server-clients
- picom
- pigz
- polybar
- postgresql-client
- pulseaudio-bluetooth
- python-pip
- rofi
- snapd
- tcpdump
- terminator
- testssl.sh
- the_silver_searcher
- thunderbird
- tmux [[3](#[3]-install-tmux-plugins)]
- unzip
- xclip
- xss-lock
- yubioath-desktop


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


### Pacman tweaks

There are some nice2have tweaks for pacman. Simply add these lines to the
`/etc/pacman.conf` file.

```
Color
# Add fancy gimmick to progres bar
ILoveCandy
```


### Faillock account lockout

Faillock with cause a temporary account lock for users, who mistype their
password too often. Usually, the default values are a lockout of 10 minutes
after 3 failed attempts. In case this is unwanted, disable faillock like so by
modifying `/etc/security/faillock.conf` (source: [Arch Wiki -
Security](https://wiki.archlinux.org/title/Security#Lock_out_user_after_three_failed_login_attempts)):

```diff
 #
 # Only track failed user authentications attempts for local users
 # in /etc/passwd and ignore centralized (AD, IdM, LDAP, etc.) users.
 # The `faillock` command will also no longer track user failed
 # authentication attempts. Enabling this option will prevent a
 # double-lockout scenario where a user is locked out locally and
 # in the centralized mechanism.
 # Enabled if option is present.
 # local_users_only
 #
 # Deny access if the number of consecutive authentication failures
 # for this user during the recent interval exceeds n tries.
 # The default is 3.
-# deny = 3
+deny = 0
 #
 # The length of the interval during which the consecutive
 # authentication failures must happen for the user account
 # lock out is <replaceable>n</replaceable> seconds.
 # The default is 900 (15 minutes).
 # fail_interval = 900
 #
 
```


### Handling lid-switch, power key pressing and similar

The handling of certain hardware events like lid-switch, short or long pressing
of power key, etc., are handled by systemd's `systemd-logind.service`.

The default settings may be viewed by running `systemd-analyze cat-config
systemd/logind.conf`. In order to override default behavior place the following
sample snippet below into a `/etc/systemd/logind.conf.d/*.conf` file (e.g.
`/etc/systemd/logind.conf.d/00-override.conf`), then restart the process via
`sudo systemctl restart systemd-logind.service`.

```ini
[Login]
HandlePowerKey=suspend
HandlePowerKeyLongPress=poweroff
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
```


### CPU clock modulation fix

Dell XPS devices may become slow after system wakeups. This is due to aggressive
[suspend settings in clock modulation
settings](https://wiki.archlinux.org/title/Dell_XPS_13_2-in-1_(7390)#Sleep/Suspend_causes_slow_system).

To fix this issue, add the systemd unit file to
`/etc/systemd/system/msr-fix.service`, then enable it via `sudo systemctl enable
msr-fix.service`. The unit file will explicitly reset the necessary CPU
register.

```ini
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
