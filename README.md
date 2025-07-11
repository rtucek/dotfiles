# Dotfiles

My dotfiles - use them and contribute your personal changes/suggestions.


## Installation

The specifically target Arch-alike distributions. For instance, the
instructions here should also work for Manjaro, which builds upon Arch.

Most importantly, it's require to install a package manager, which
makes use of the AUR. [yay](https://github.com/Jguer/yay) is by far
the best one I've ever seen and can simply be installed like so.

```bash
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

Then, you'd want to install all relevant packages from the [General
packages](#general-packages), [Fonts](#fonts) and [AUR](#aur) sections.

Dotfiles are managed by [`chezmoi`](https://github.com/twpayne/chezmoi). Run
`chezmoi init rtucek` in order to download all dotfiles, followed by `chezmoi
cd` for jumping directly to the git repo of the dotfiles.

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

- alsa-utils
- arandr
- arch-audit
- autorandr [[8]](#autorandr-post-installation-activation-[8])
- bash-completion
- bat [[1]](#syntax-highlight-with-bat-and-cat-[1])
- bluetui
- bluez
- bluez-utils
- bolt [[4]](#fix-hotplug-issue-with-thunderbolt-[4])
- brightnessctl
- chezmoi
- ctags
- devspace-bin
- diff-so-fancy
- dmidecode
- docker [[2]](#docker-post-installation-[2])
- docker-compose
- dog
- dunst
- firefox
- fwupd
- fzf
- gimp
- git-delta [[1]](#syntax-highlight-with-bat-and-cat-[1])
- glab
- globalprotect-openconnect
- gnome-keyring
- gnu-netcat
- go
- gparted
- gufw
- gzip
- helm
- helvum
- httpie
- i3-battery-popup-git
- imagemagick
- inxi
- ipcalc
- jless
- jq
- k9s
- kubectl
- lastpass-cli
- less
- litecli
- lsb-release
- lshw
- lsof
- man-db
- mkcert
- msr-tools
- mtr
- mycli
- mysql-workbench
- neovim
- networkmanager-openconnect
- nitrogen
- openconnect
- openssh
- osquery
- pcmanfm
- percona-server-clients
- percona-toolkit
- pgcli
- picom
- pigz
- pipewire [[7]](#pipewire-post-installation-activation-[7])
- pipewire-pulse
- playerctl
- polkit-gnome
- polybar [[6]](#permissions-for-polybar-[6])
- postgresql-client
- pw-volume
- pwgen
- python-pip
- python-pipx
- python-pynvim
- qemu-full
- ranger
- rofi
- rsync
- ruby-erb
- scrot
- snapd
- sound-theme-freedesktop
- speedtest-cli
- stern
- strongswan
- tcpdump
- tela-circle-icon-theme-manjaro
- terminator
- testssl.sh
- the_silver_searcher
- thunderbird
- tmux [[3]](#install-tmux-plugins-[3])
- torbrowser-launcher
- tree
- tree-sitter-cli
- udiskie
- udisks2
- ufw [[5]](#ufw-post-install-actions-[5])
- unzip
- usbutils
- veracrypt
- vi
- whois
- wireplumber
- xclip
- xorg-xinput
- xorg-xkill
- xss-lock
- yay
- yubioath-desktop


### FS support

- bcachefs-tools
- btrfs-progs
- btrfs-tools
- cryptsetup
- dosfstools
- exfatprogs
- hfsprogrs
- hfsutils
- lvm2
- mtools
- ntfs-3g
- ntfs-progrs


### Fonts

- noto-fonts
- noto-fonts-cjk
- noto-fonts-emoji
- ttf-dejavu
- ttf-font-awesome
- ttf-input-nerd
- ttf-joypixels


### AUR

- 1password
- 1password-cli
- auto-cpufreq [[9]](#auto-cpufreq-post-installation-activation-[9])
- certigo
- csvtools-git
- google-chrome
- kind-bin
- nvm
- postman-bin
- ptcpdump
- tmuxinator
- unimatrix-git
- xidlehook


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
nvm alias default "lts/*" # Alias most recent lts node version as default
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
pipx install python-language-server # (coc-python)
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
sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

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
+# Have a masked password indicator, when typing the password for sudo
+Defaults pwfeedback
```


### Pacman tweaks

There are some nice2have tweaks for pacman. Simply add these lines to the
`/etc/pacman.conf` file (or uncomment existing ones).

```diff
+# Have colored output
+Color
+# Add fancy pacman gimmick to progres bar
+ILoveCandy
+# Multiple simultaneous downloads
+ParallelDownloads = 5
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
systemd/logind.conf`.

In order to override default behavior, create a drop-in for the config file
by adding overrides into any `/etc/systemd/logind.conf.d/*.conf`.
This is typically done by:

```bash
sudo mkdir -p /etc/systemd/logind.conf.d
systemd-analyze cat-config systemd/logind.conf | sudo tee /etc/systemd/logind.conf.d/90-logind.conf
```

Then, open `/etc/systemd/logind.conf.d/90-logind.conf` and leave only your
overrides un-commented. Below are some sample customizations.

```diff
--- /etc/systemd/logind.conf
+++ /etc/systemd/logind.conf.d/90-logind.conf
@@ -1,3 +1,4 @@
+# /etc/systemd/logind.conf
 #  This file is part of systemd.
 #
 #  systemd is free software; you can redistribute it and/or modify it under the
@@ -24,18 +25,18 @@
 #KillExcludeUsers=root
 #InhibitDelayMaxSec=5
 #UserStopDelaySec=10
-#SleepOperation=suspend-then-hibernate suspend
-#HandlePowerKey=poweroff
-#HandlePowerKeyLongPress=ignore
+SleepOperation=suspend-then-hibernate suspend
+HandlePowerKey=suspend
+HandlePowerKeyLongPress=poweroff
 #HandleRebootKey=reboot
 #HandleRebootKeyLongPress=poweroff
 #HandleSuspendKey=suspend
 #HandleSuspendKeyLongPress=hibernate
 #HandleHibernateKey=hibernate
 #HandleHibernateKeyLongPress=ignore
-#HandleLidSwitch=suspend
-#HandleLidSwitchExternalPower=suspend
-#HandleLidSwitchDocked=ignore
+HandleLidSwitch=suspend
+HandleLidSwitchExternalPower=suspend
+HandleLidSwitchDocked=suspend
 #HandleSecureAttentionKey=secure-attention-key
 #PowerKeyIgnoreInhibited=no
 #SuspendKeyIgnoreInhibited=no
```

Finally, run `sudo systemctl reload systemd-logind.service` in order to have any
changes being applied.

Links:
- [LOGIND.CONF(5)](https://man.archlinux.org/man/logind.conf.5.en)
- [SYSTEMD-LOGIND.SERVICE(8)](https://man.archlinux.org/man/systemd-logind.8)


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


### GPG keyservers

My GPG keys are generally distributed via the following public keyservers:
- keys.openpgp.org
- keyserver.ubuntu.com
- pgp.mit.edu


### Fix automatic wake ups from suspend

For some Tuxedo Laptops, the Laptop wakes up automatically within a couple of
seconds. This is due to a bug in the BIOS, which can be seen in the syslog,
based on these log entries:

```
[...]
xxx xx xx:xx:xx archlinux kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.ACDC.RTAC], AE_NOT_FOUND (20230628/psargs-332)
xxx xx xx:xx:xx archlinux kernel: ACPI Error: Aborting method \_SB.PEP._DSM due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[...]
```

For mitigation, the kernel parameter `acpi.ec_no_wakeup=1` must be set in
`/etc/default/grub`:

```diff
-GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi.ec_no_wakeup=1"
```

> Don't forget to run `sudo update-grub` in order re-build and deploy the grub
> config, so that it becomes effective from the next system boot onwards..

For testing purpose, the `acpi.ec_no_wakeup=1` parameter can also be set at
post-boot with the sysfs interface:

```bash
# Read current state of acpi.ec_no_wakeup via ...
cat /sys/module/acpi/parameters/ec_no_wakeup
# ... Y -> 1 (on); N -> 0 (off)
# Set the value by writing 1 or 0 to the file: e.g.
echo "1" | sudo tee /sys/module/acpi/parameters/ec_no_wakeup
```

It's worth pointing out, that even with setting the parameter, the error will
still be logged to syslog, however the automatic wake ups are prevented this
way.


Links:
- [Tuxedo FAQ / Device Immediately Wakes Up After Suspend](https://www.tuxedocomputers.com/en/FAQ-TUXEDO-InfinityBook-Pro-15-Gen9.tuxedo#3675)
- [Arch Wiki / /sys/module/acpi/parameters/ec_no_wakeup](https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#/sys/module/acpi/parameters/ec_no_wakeup)


### ufw post-install actions [5]

[Uncomplicated Firewall (aka
ufw)](https://wiki.archlinux.org/title/Uncomplicated_Firewall) may not be active
right away post-install. This can be fixed with systemd.

```bash
sudo systemctl enable --now ufw.service
```

Further, even if ufw is started via systemd, ufw may not be initialized. Run the
following commands in order to check and fix (if needed).

```bash
$ sudo ufw status
Status: inactive
# explicitly enable ufw
$ sudo ufw enable
Firewall is active and enabled on system startup
```

Finally, check if the current rules are the "sane and sensitive defaults":

```bash
$ sudo ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip
```

Mind the `Default: deny (incoming), allow (outgoing), deny (routed)` line. In
case default rules are different by default, you may correct them with:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed
```

Links:
- [Arch Wiki / Uncomplicated Firewall](https://wiki.archlinux.org/title/Uncomplicated_Firewall)
- [Ubuntu Wiki / UFW](https://help.ubuntu.com/community/UFW)


### Have systemd using same default console editor

By default, systemd may use any available console-based editor.
However, the `SYSTEMD_EDITOR` ENV allows configuring any editor of preference.
In order to have `sudo` based commands inheriting this ENV, add the following
line to the sudoers file manually via `visudo`.

```diff
 ##
 ## Preserve editor environment variables for visudo.
 ## To preserve these for all commands, remove the "!visudo" qualifier.
 Defaults!/usr/bin/visudo env_keep += "SUDO_EDITOR EDITOR VISUAL"
+Defaults env_keep += "SYSTEMD_EDITOR"
 ##
 ## Use a hard-coded PATH instead of the user's to find commands.
```


### Permissions for Polybar [6]

Many modules may not work out of the box. Inspect
`~/.config/polybar/config.ini`, which might require a few parameters to be
properly templated via chezmoi.

#### Change backlight via scrolling

For having support for changing the backlight via scrolling, do the following:

1) Add your user to the `video` group.

```bash
sudo usermod -aG video $USER
newgrp video
```

2) Add the following udev rule `/etc/udev/rules.d/99-backlight.rules`

```
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
```

Reload udev via:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

In case it does not work, try rebooting the system.


### Pipewire post-installation activation [7]

[`pipewire`](https://wiki.archlinux.org/title/PipeWire) is used as the audio
router and processor. For audio session management,
[`wireplumber`](https://wiki.archlinux.org/title/WirePlumber) is used.

Additionally, the `pipewire-pulse` package is installed for mimicking
[`pulseaudio`](https://wiki.archlinux.org/title/PulseAudio) for some
applications. In order to have both services working reliably, make sure systemd
is running them upon startup.

[`helvum`](https://gitlab.freedesktop.org/pipewire/helvum) may be used as
patchbay GUI for pipewire.

```bash
systemctl enable --user --now pipewire.service
systemctl enable --user --now pipewire-pulse.service
```


### Autorandr post-installation activation [8]

[`autorandr`](https://github.com/phillipberndt/autorandr) is used to
automatically detect monitors, storing profiles and auto-applying them upon
reconnect.

In order to work properly, the following 2 systemd services should be activated:

```bash
sudo systemctl enable --now autorandr.service
sudo systemctl enable --now autorandr-lid-listener.service
```


### Bluetooth support

For having [Bluetooth](https://wiki.archlinux.org/title/Bluetooth) working, the
`bluetoothd` daemon must run in the background.
Run the following systemd command in order to run bluetoothd from the beginning.

```bash
sudo systemctl enable --now bluetooth.service
```

Tools like [`bluetui`](https://github.com/pythops/bluetui) and
`bluetoothctl` may be used for frontends for interacting.


### Yubikey support

[Yubikey](https://wiki.archlinux.org/title/YubiKey) builds upon the smartcard
interface, whose service may not be running.
You may enable the service to become available via systemd activation:

```bash
sudo systemctl enable --now pcscd.service
```


### auto-cpufreq post-installation activation [9]

THe `auto-cpufreq` daemon need to be activated via systemd first.

```bash
sudo systemctl enable --now auto-cpufreq
```

Once done, `auto-cpufreq --stats` allows live-observing the profile. For
instance on AC, the `performance` governor will be applied, otherwise the
`powersave` governor when relying on battery.
