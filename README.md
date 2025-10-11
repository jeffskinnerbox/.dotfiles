<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<!--
<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg"
        title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>
-->

# NOTES TO SELF

Write instructions on installing Stow, Git, Vim, Tmux, etc.

---------------

## Install on MacBook

#### Step X: Install MacBook Tools - DONE

- [Command Line Developer Tools]()
- [Homebrew]()
- [MacPorts][08], formerly DarwinPorts, is a package manager for macOS and Darwin.
  It is an open-source software project that aims to simplify the installation of other open source software.
  MacPorts supports [universal binaries][07] for PowerPC, Intel-based, and Apple silicon versions of macOS.

```bash
# install apple's command line developer tools
xcode-select --install

# accept the Xcode license by either launching Xcode or running this command
sudo xcodebuild -license accept

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install macports for your version of the mac os - see https://www.macports.org/install.php
cd ~/Downloads
curl -O https://github.com/macports/macports-base/releases/download/v2.9.3/MacPorts-2.9.3-14-Sonoma.pkg
sudo installer -pkg ~/Downloads/MacPorts-2.9.3-14-Sonoma.pkg -target /
```

To assure `port` works, you must set in `.bashrc` the following line: `export PATH=/opt/local/bin:/opt/local/sbin:$PATH`.
You need to do this **only** for MacOS.

To update outdated ports, do the following

```bash
# update outdated ports
sudo port selfupdate
sudo port upgrade outdated
```

To uninstall MacPorts - <https://guide.macports.org/chunked/installing.macports.uninstalling.html>

Sources:

- [The MacPorts Project Official Homepage](https://www.macports.org/install.php)

#### Step X: Install Nerd Fonts - DONE

Nerd Fonts and I use lots of icons throughout my development environment. There are dozens of Nerd Fonts to choose from but as a macOS user I’ve prefer Apple’s San Francisco font which is a neutral, flexible, sans-serif typeface used as the system font for all Apple devices.

- [GitHub: ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file)
- [GitHub Gist: davidteren/nerd_fonts.md](https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e)

```bash
# install all nerd fonts
brew tap homebrew/cask-fonts

# list all the nerd fonts
brew search '/font-.*-nerd-font/'

# find your desired nerd fonts
$ brew search '/font-.*-nerd-font/' | grep -e meslo -e jetbrains
caskroom/cask/font-jetbrains-mono-nerd-font
caskroom/cask/font-meslo-lg-nerd-font
font-jetbrains-mono-nerd-font
font-meslo-lg-nerd-font

# install desired nerd fonts
#brew install --cask font-jetbrains-mono-nerd-font
#brew install --cask font-meslo-lg-nerd-font
brew install font-jetbrains-mono-nerd-font
brew install font-meslo-lg-nerd-font
```

#### Step X: Install a True Color Termuinal (iTerm2)

To mkae the color scheme work properly, you need a true color terminal.
I'm using [iTrerm2]().

```bash
# install a true color terminal
brew install --cask iterm2
```

You can find iTerm2 via the MacBook Finder and click on it and
Select the button for autromatic updates.

Using **Command-,** you get the Settings (aka Preferances) window for iTerrm2

- Goto **Profile** > **Text**: Font size `14`.
- Goto **Profile** > **Colors** > **Color Presets...**: iSet to **Solarized**

Add iTerm2 to <the bottom> and remove the MacOS Terminal App to make it your default terminal for the MacBook.

#### Step X: Install `.dotfiles` & Required Tools - DONE

[Dotfiles]()
[Git]()
[Stow]()

```bash
# install .dotfile required tools
brew install git stow

# install .dotfiles
cd $HOME
git clone <https://github.com/jeffskinnerbox/.dotfiles.git>
```

Sources:

- [Bash + GNU Stow: take a walk while your new macbook is being set up](https://medium.com/@protiumx/bash-gnu-stow-take-a-walk-while-your-new-macbook-is-being-set-up-351a6f2f9225)

#### Step X: Install Gnome Terminal - DONE but not working (consider removing)

[Gnome Terminal]()

```bash
# install gnome-terminal
sudo port install gnome-terminal

# To see what files were installed by gnome-terminal
port contents gnome-terminal
````

If you wish to update or remove `gnome-terminal` at a later date, do the following:

```bash
# to later update gnome-terminal
sudo port selfupdate && sudo port upgrade gnome-terminal

# remove gnome-terminal
```

If you wish to update or remove MacPorts at a later date, do the following:

```bash
# to later update mcports
# https://guide.macports.org/chunked/installing.macports.upgrade.html

# remove macports and all thing it ported in
# https://guide.macports.org/chunked/installing.macports.uninstalling.html
sudo port -fp uninstall installed
sudo dscl . -delete /Users/macports
sudo dscl . -delete /Groups/macports
sudo rm -rf \
    /opt/local \
    /Applications/DarwinPorts \
    /Applications/MacPorts \
    /Library/LaunchDaemons/org.macports.* \
    /Library/Receipts/DarwinPorts*.pkg \
    /Library/Receipts/MacPorts*.pkg \
    /Library/StartupItems/DarwinPortsStartup \
    /Library/Tcl/darwinports1.0 \
    /Library/Tcl/macports1.0 \
    ~/.macports
```

Sources:

- [gnome-terminal](https://ports.macports.org/port/gnome-terminal/)
- [Uninstall MacPorts](https://guide.macports.org/chunked/installing.macports.uninstalling.html)

#### Step X: Install `.dotfiles` Packages

[Tmux]()
[NeoVim]()

To open a terminal from the commandline within your present working directory,
use the following command: `open -a Terminal "$(pwd)"`.

```bash
# install tmux
brew install tmux
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-tmux

# install neovim
brew install neovim
mkdir -p $XDG_CONFIG_HOME
/Users/jeffirland/.dotfiles/README.md stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-nvim
```

open -a Terminal /usr/local/bin/nvim ~/.dotfiles

Sources:

- [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM)
- [How I Setup Neovim On My Mac To Make It Amazing - Complete Guide](https://www.youtube.com/watch?v=vdn_pKJUda8)

----

## Install on Linux (Ubuntu)

----

First do this let do a test run of the installation process:

```bash
# create your test directories
mkdir -p ~/tmp/test/.config

# simulate stow package creation of using ~/.dotfiles
stow --simulate --verbose=5 --dir=$HOME/.dotfiles --target=$HOME/tmp/test --stow <package-directory>

# stow nvim package - aka create your symlinks for your nvim configuration files
stow --dir=$HOME/.dotfiles --target=$HOME/tmp/test --stow <package-directory>

# inspect what you have just created
ls -al ~/tmp/test
ls -al ~/tmp/test/.config

# undo / remove your stow creation
stow --dir=$HOME/.dotfiles --target=$HOME/tmp/test/ --delete <package-directory>
```

Now let us do it for real:

```bash
# put into you '.bashrc' file the environment variable for the path to `.config` directory
export XDG_CONFIG_HOME=$HOME/.config

# stow nvim package - aka create your symlinks for your nvim configuration files
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-X
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-i3
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-vim
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-tmux
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-bash
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-conky
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-screen
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-nvim
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-yamllint
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-alacritty
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-ansible-lint

# and if you wish to undo this for any reason ....
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-X
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-i3
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-vim
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-tmux
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-bash
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-conky
stow --dir=$HOME/.dotfiles --target=$HOME --delete pkg-screen
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --delete pkg-nvim
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --delete pkg-yamllint
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --delete pkg-alacritty
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --delete pkg-ansible-lint
```

```
# WORK IN PROGRESS .... not in working order yet
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-scripts
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-conda
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-cura
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-git
```

## Dotfiles Directory: ~/.dotfiles

Like many, I have multiple Linux machines that I have setup to rule my computational life style.
Also like many, I want to avoid surprises in my computational life.
I want to move freely among my systems and have at my finger tips all the same
tools and resources that I have grown accustom too.
This requires strict consistence for the user experience,
despite the differences in the environments the tools are location.
Given that in the Linux world, tool behavior is often dictated by [dotfiles][01],
it is these dotfile that must be consistent on each system.
This [Dotfiles Directory][01] is a key player to making things easier for me.

To find out more about creating and managing your `.dotfiles`,
check out the documentation and videos below:

- [dotfiles][02]
- [Dotfiles – What is a Dotfile and How to Create it in Mac and Linux](https://www.freecodecamp.org/news/dotfiles-what-is-a-dot-file-and-how-to-create-it-in-mac-and-linux/)
- [The Basics of Dotfiles](https://www.youtube.com/watch?v=BE87kUCTBVU)
- [Dotfiles! Here's how I organize them.](https://www.youtube.com/watch?v=5oXy6ktYs7I)
- [How to Create a Dotfiles Folder](https://www.youtube.com/watch?v=gibqkbdVbeY)
- [Give Your Dotfiles a Home with GNU Stow](https://www.youtube.com/watch?v=CxAT1u8G7is&t=905s)
- [Using GNU Stow to Manage Symbolic Links for Your Dotfiles](https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/)

----

## Installation of Dotfiles & Required Tools

The contents of the `http://github.com/jeffskinnerbox/.dotfiles.git`
[Git][05] repository includes all the instructions and tools
required for testing and installation of my `.dotfiles`.
You can quickly clone the Git repository on the target machine,
run some simple scripts, re-login or reboot, and get yourself underway.
This simple and quick procedure will be document here.

If your unfamiliar with `.dotfiles` and how the tools used here operate,
it could be wiser for you to jump to the "Dry-Run Testing" section
and follow those procedure first.
This will give you a safe way to try thing out before you commit to
a complete installation on your target machine.

#### Step X: Creating Your Local Git Repository

Clone the `.dotfiles` Git Repository within your `$HOME` directory.

```bash
# clone .dotfiles directory
cd $HOME
git clone http://github.com/jeffskinnerbox/.dotfiles.git
```

#### Step X: Install Stow

Very first step is to install Stow on your machine:

```bash
# install stow
sudo apt install stow
```

----

## Dry-Run Testing

Prior to doing a full install of the `.dotfiles`,
you may want to perform some testing in a safe place.
You have two options:

- **Use a Virtual Machine -**
  The first is test outside your target machine,
  and perform the installation on a virtual machine.
  This will completely protest you from anything going badly.
- **Use a Temporary Directory -**
  The second option is to use your target machine,
  but instead of installing on you home directory,
  make the target a safe place like `/tmp` or a custom directory of your choose.

There are procedure listed below for both these options.

## Dry-Run Testing Use a Virtual Machine

For this type of testing,
I'll make use of [Vagrant][03] and [Ansible][04] as tools to quickly
and reliable set up testing environments.
Within the `~/.dotfiles/test` directory are references to a VagrantFile and Ansible Playbook.
Vagrant will be used to spin-up some virtual machines (VM) via the `~/.dotfiles/test/VagrantFile`
and then VMs will provisioned via the `~/.dotfiles/test/playbooks/playbook.yml`

There are the following phases to standing-up the Dry-Run Testing:

- Prepare Your Tools
- Prepare Virtual Machines
- Prepare Virtual Machines for Provisioning
- Provision Virtual Machines

### Prepare Your Tools

#### Step X: Install Vagrant

To create the virtual machine where testing will be perfromed,
I make use of [Vagrant][03].
See `~/.dotfiles/docs/using-vagrant-docker-and-ansible.md` to understand how to do this.

#### Step X: Install Ansible

[Ansible][04] will be used to build the VM test envirment once Vagrant has established those VMs.
The Ansible host computers could exist anywhere, including on the target machine,
as long as all are reachable via SSH.
On your Ansible host machine,
your first step is to install Ansible and any extension you may want to use.
See `~/.dotfiles/docs/using-vagrant-docker-and-ansible.md` to understand how to do this.

### Prepare Virtual Machines

#### Step X: Create VM Testing Environment

Assuming Vagrant is installed and properly configured,
the `VagrantFile` and Ansible's `playbook.yml` is ready to establish the testing VMs.

```bash
# spin-up the virtual machines
cd ~/.dotfiles/test
vagrant up
```

### Prepare Virtual Machines for Provisioning

#### Step X: Installing Ansible on Ansible Server

The Ansible host computers could exist anywhere as long as they are reachable via SSH.
On your Ansible host machine,
your first step is to install Ansible and any extension you may want to use.
See `~/.dotfiles/docs/using-vagrant-docker-and-ansible.md` to understand how to do this.

#### Step X: Copy SSH Keys to Client

Ansible primarily communicates with client computers through SSH.
While it has the ability to handle password-based SSH authentication,
using SSH keys can help to keep things simple.
(Check [here][06] if you need more information concerning SSH,
how to generate keys, using keys, etc.)

On my Ansible server, I have created a specific SSH key for Ansible work.
That key is `~/.ssh/ansible.pub`.

##### Method A: Copying Public Key Using `ssh-copy-id`

The simplest method to provide the SSH keys to the client computer
is to use the `ssh-copy-id` tool.
Launching from the Ansible server, the syntax is:
`ssh-copy-id username@remote_host`.
In my case:

```bash
# from my desktop computer, copying public key using ssh-copy-id
ssh-copy-id -i ~/.ssh/ansible.pub pi@home-assist

# or
ssh-copy-id -i ~/.ssh/ansible.pub pi@192.168.1.203
```

To test if this is successful,
login to your Ansible client via SSH: `pi@192.168.1.203`
and you should get in without being prompted for a password.

##### Method B: Copying Public Key Using SSH

If you do not have `ssh-copy-id` available on your computer,
but you have password-based SSH access to an account on your server,
you can upload your keys using a conventional SSH method:

```bash
# from my desktop computer, copying public key using ssh
cat ~/.ssh/ansible.pub | ssh pi@home-assist "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

##### Method C: Copying Public Key Manually

The final method is just to do it all manually.
Assuming SSH is already established on your Ansible server,
use the `cat` command to print the contents of your
non-root user’s SSH public key file to the terminal’s output:

```bash
# copy this public ssh key
cat ~/.ssh/id_rsa.pub
```

Copy the resulting output to your clipboard,
then open a new terminal and connect to one of your Ansible hosts using SSH,
and do the following:

1. Switch to the client machine’s root user.
1. As the root user, open the `authorized_keys` within the `~/.ssh` directory:
1. In the file, paste your Ansible server user’s SSH key, then save the file.

#### Step X: Creating Hosts File

Ansible needs to know your remote server names or IP address.
This information is stored in a file called `hosts`, or often refered to as your "inventory".
The default file is `/etc/ansible/hosts`.
You can edit this one or create a new one in your `$HOME` directory,
or better yet, place the `hosts` file in your projects directory referance it
on the command-line when running `ansible`.

```bash
# create the hosts (aka inventory) file for your raspberry pi
cat <<EOF > inventory
# Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
# Version:      0.0.1

# aka ansible hosts file

# ansible control node
#[controller]
#127.0.0.1 ansible_connection=local

# ansible managed hosts (aka nodes)
[nodes]
home-assist ansible_ssh_host=192.168.1.203 ansible_ssh_port=22 kubernetes_role=node
#node-1 ansible_ssh_host=192.168.33.231 ansible_ssh_port=22 kubernetes_role=master
#node-2 ansible_ssh_host=192.168.33.232 ansible_ssh_port=22 kubernetes_role=node
#node-3 ansible_ssh_host=192.168.33.233 ansible_ssh_port=22 kubernetes_role=node

# ansible varables applied to [nodes]
[nodes:vars]
ansible_user='pi'
ansible_ssh_user=pi
deploy_target=pi
ansible_become=yes
ansible_become_method=sudo
ansible_python_interpreter='/usr/bin/env python3'
#ansible_python_interpreter=/usr/bin/python3
EOF
```

### Provision Virtual Machines

#### Step X: Run Ansible Playbook

```bash
# provision the software to create the testing envirnment
ansible-playbook -i inventory -l nvimtest ~/.dotfiles/test/playbooks/playbook.yml --tags install
```

## Dry-Run Testing Use a Temporary Directory

[01]: https://askubuntu.com/questions/94780/what-are-dot-files
[02]: https://dotfiles.github.io/
[03]: https://www.vagrantup.com/
[04]: https://www.ansible.com/
[05]: https://git-scm.com/
[06]: https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-1804
[07]: https://en.wikipedia.org/wiki/Universal_binary
[08]: https://guide.macports.org/

[09]:
[10]:
