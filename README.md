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

- 1password-cli
- arch-audit
- [autorandr](https://github.com/phillipberndt/autorandr)
- bash-completion
- bat [[1]](#syntax-highlight-with-bat-and-cat-[1])
- bolt [[4]](#fix-hotplug-issue-with-thunderbolt-[4])
- brightnessctl
- chezmoi
- ctags
- devspace-bin
- diff-so-fancy
- docker [[2]](#docker-post-installation-[2])
- docker-compose
- dog
- firefox
- fwupd
- git-delta [[1]](#syntax-highlight-with-bat-and-cat-[1])
- glab
- gnome-keyring
- gnu-netcat
- go
- gzip
- helm
- i3-battery-popup-git
- i3-scrot
- ipcalc
- jless
- jq
- k9s
- kubectl
- lastpass-cli
- mkcert
- msr-tools
- mysql-workbench
- neovim
- osquery
- pavucontrol
- percona-server-clients
- percona-toolkit
- picom
- pigz
- playerctl
- polybar
- postgresql-client
- pulseaudio-bluetooth
- pwgen
- python-pip
- rofi
- snapd
- stern
- tcpdump
- terminator
- testssl.sh
- the_silver_searcher
- thunderbird
- tmux [[3]](#install-tmux-plugins-[3])
- unzip
- whois
- xclip
- xss-lock
- yubioath-desktop


### Fonts

- ttf-dejavu
- ttf-font-awesome
- ttf-joypixels


### AUR

- certigo
- csvtools-git
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
# SQL CLIs, by courtesy of https://github.com/dbcli
pip install --user --upgrade litecli
pip install --user --upgrade mycli
pip install --user --upgrade pgcli

pip install --user --upgrade pynvim # (neovim python provider)
pip install --user --upgrade python-language-server # (coc-python)
```


### Bash completion

- composer (`cgr require bamarni/symfony-console-autocomplete`)
- tmux (https://github.com/imomaliev/tmux-bash-completion/blob/master/completions/tmux)
- yarn (https://github.com/dsifford/yarn-completion/blob/master/yarn-completion.bash)


## Addendum

### Syntax highlight with bat and cat [1]

As a special case, in order to have syntax highlighting for PHP work with
`bat` in combination with `delta` diffs, refer to [these
instructions](https://github.com/dandavison/delta/issues/162#issuecomment-625952288).

It's necessary to perform this step, whenever `bat` gets updated.


### Docker post-installation [2]

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


### Install tmux plugins [3]

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

Some Dell XPS devices may become slow after system wakeups. This is due to
aggressive [suspend settings in clock modulation
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


### Fix hotplug issue with Thunderbolt [4]

Given the following symptoms:
> Devices, connected via Thunderbolt don't work if "hot plugged in" (that is,
> after the OS has booted). However, if the device is connected at cold boot
> time, the device works mystically. In particular, to a Dock connected devices
> like keyboards and mouses don't assume to have any powered state (e.g. the
> laser pointer of a mouse remains switched off).

This is due to the [OS' security
settings](https://wiki.archlinux.org/title/Thunderbolt#User_device_authorization).
The OS - by default - protects against [DMA
attacks](https://en.wikipedia.org/wiki/DMA_attack) such as
[Thunderstrike](https://trmm.net/Thunderstrike_2/), by setting the security mode
to `user` or `secure`. So the in some form or another, we have to "approve" the
connected device.

One way to simply get away with it, is to add a udev rule to
`/etc/udev/rules.d/99-removable.rules`, which just authorizes essentially every
hot-plugged Thunderbolt device:

```
ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"
```

The rule will become effective after the next reboot, however you can also avoid
a reboot by live-reloading udev rules:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

However, a much simpler approach would be actually authorizing the device via
`bolt`.

Sources:
- [Thunderbolt](https://wiki.archlinux.org/title/Thunderbolt)
- [Thunderbolt - udev rule (Arch Wiki)](https://wiki.archlinux.org/title/Thunderbolt#Automatically_connect_any_device)
- [Live-reload udev rule (unix.stackexchange.com)](https://unix.stackexchange.com/a/39371/213414)
