<!-- vim: ts=2 sts=2 sw=2 et                                                    -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->

<!-- markdownlint-disable MD001 MD012 MD033 MD041 MD045 -->
<!-- markdownlint-configure-file { "line-length": { "line_length": 300 } } -->
<!-- markdownlint-configure-file { "hr-style": { "style": "--------------- } } -->
<!-- markdownlint-configure-file { "blanks-around-headings": { "lines_above": 2, "lines_below": 0, } } -->
<!-- see [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg"
    title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


* [Sync your .dotfiles with git and GNU #Stow like a pro!](https://www.youtube.com/watch?v=CFzEuBGPPPg)

* [Yet Another Dotfiles Manager](https://yadm.io/#)
  * [A Better Way To Manage Your Dotfiles | yadm](https://www.youtube.com/watch?v=lR1UihK82qg)
  * [Managing Dotfiles with YADM: The Easy Way](https://medium.com/@julius.dehner/how-i-manage-my-dotfiles-with-yadm-4cbdb0d35d34)
  * [Dotfile management with YADM](https://blog.dmichael.be/2021/02/19/Dotfile-management-with-YADM/)




* [Sync files across multiple devices with Syncthing](https://opensource.com/article/20/1/sync-files-syncthing)



* [The ultimate dotfiles setup](https://www.youtube.com/watch?v=-RkANM9FfTM)
* [Automating your Dotfiles with Ansible: A Showcase](https://www.youtube.com/watch?v=hPPIScBt4Gw)


---------------


# Dotfiles Directory: /home/jeff/.dotfiles
Like many, I have multiple Linux machines that I have setup to rule my computational life style.
Also like many, I want to avoid surprises in my computational life.
I want to move freely among my systems and have at my finger tips all the same
tools and resources that I have grown a custom too.
This requires strict consistence on how these tools work in each location,
and given that in the Linux world tool behavior is often dictated by dotfiles,
it is these dotfile that must be consistent on each system.

So how do you maintain this consistency with minimal pain & effort?
Dotfiles are the personalization of tools and resources for my specific needs.
I may choose at any moment, at any location to update my `vim` editor with a new clever idea
and I want it to be present every where among my systems.

Many manage this challenge by using a directory configuration, also known as dotfiles,
along with version control `git`.
This allows for keeping track of changes and synchronizing the dotfiles across different machines.
But even with a common directory for all your machines,
you still how do you make sure that your `~/.bashrc`, `~/.vimrc`, `~/.config/nvim/init.lua`, etc.
appear in the proper places in your home directory.
Using symlinks comes to mind but how do you manage all these links?
Yes you could manual create the links or write some custom scripts,
but managing this problem is what the utilities `stow` and `syncthing` can do for you.

I'm not the first to want to solve this problem,
as illustrated by my sources below,
but this is my way to minimize pain for me.
It has some things that are "unique",
for example making use of Ansible to provide build automation and assure consistency,
something not often done.

To find out more on creating and managing your dotfiles,
check out the documentation and videos below:

* [dotfiles](https://dotfiles.github.io/)
* [The Basics of Dotfiles](https://www.youtube.com/watch?v=BE87kUCTBVU)
* [How to Create a Dotfiles Folder](https://www.youtube.com/watch?v=gibqkbdVbeY)
* [Give Your Dotfiles a Home with GNU Stow](https://www.youtube.com/watch?v=CxAT1u8G7is&t=905s)
* [Using GNU Stow to Manage Symbolic Links for Your Dotfiles](https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/)


## Stow
The main concept behind stow it’s very well explained in the [Stow program manual][01]:

_The approach used by Stow is to install each package into its own tree,
then use symbolic links to make it appear as though the files are
installed in the common tree._

Another definition widely used is:

_Stow is a glorified symlink farm manager.
It manages symlinks from A to B.
It takes distinct packages of software and/or data located in separate directories on the filesystem,
and makes them appear to be installed in the same place.
By default, it makes symlinks from the directory it is in to the directory below it.
It is a tool made for system administrators that need to maintain software
on machine and may need to add/remove software packages._

Thus you can manage majority of your configuration files under the same directory location (aka `.dotfiles`)
and soft link them to different places where they need to be placed (e.g. by tradition or design like `$HOME`).
The stow directory is the root directory which contains all the stow packages,
each with their own private subtree.
The typical stow directory is `$HOME/.dofiles`, and inside it, each subdirectory represents a "package".
In stow‘s terminology, a "package" is a set of files & directories that need
to be “installed” in a particular directory structure.
The target directory is the root of the tree in which the package appear to be installed.

When you “stow” a package, stow creates symlinks in the target directory that point into the package
within the `.dotfiles` directory.

Let’s say I have my dotfiles repository in `~/src/dotfiles/`.
Within this repository, I have a vim package, containing the `.vimrc` dotfile.

```
Using command: tree -a --filesfirst ~/.dotfiles/pkg-nvim

.dotfiles
├── .stow-local-ignore    <-- stow will skip files referance in here
├── bash
│   └── README.md
├── bin
├── conky
│   ├── .conkyrc
│   └── README.md
├── git
│   ├── .gitconfig
│   └── README.md
├── nvim                  <-- the package
│   ├── README.md
│   └── .config           <-- the nvim configuration file (aka dotefile)
│       └── nvim
│           └── init.lua
└── vim
    ├── README.md
    └── .vimrc
```

The target directory is my home directory,
as this is where the symlinks need to be created.
I can now stow the `nvim` configuration file into the target directory like so:

```bash
# place the nvim configuration files into its target location
stow --target=$HOME/config nvim

# remove the nvim configuration files (the '/' is significant !!!)
stow --target=$HOME/config nvim --delete nvim/
```

By default, stow assumes that the target directory
is the parent directory of the one that you specified.
This means that `stow .` is equivalent to `stow --dir=~/.dotfiles --target=~/`.

Note that the name of the package (i.e. the name of the directory)
does not matter as stow points the symlinks into the package, so you can choose it freely.


* [Stow Manual][01]
* [How to use GNU Stow to manage programs installed from source and dotfiles](https://linuxconfig.org/how-to-use-gnu-stow-to-manage-programs-installed-from-source-and-dotfiles)
* [Managing my dotfiles with GNU Stow](https://medium.com/@waterkip/managing-my-dotfiles-with-gnu-stow-262d2540a866)
* [Use Stow for configuration management of multiple machines](https://opensource.com/article/20/1/configuration-management-stow)
* [Easily manage your Linux config files with Stow](https://dbeley.ovh/en/post/2021/01/09/easily-manage-your-linux-config-files-with-stow/)
* [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)


## Syncthing
The advantage of something like Syncthing is that it is always working on your behalf.
I wondered if remembering to make my manual commits, pushes, and pulls was going to be a problem?


---------------


















# Install Your $HOME/.dotfiles

## Preparatory Steps for Dotfiles Installation

#### Step X: Install OpenSSH - DONE
I'm going to want to remove the monitor / keyboard / mouse from my system and use SSH for access.
You can check to make sure `ssh` is working by via `ssh user-name@YourBox.local`.
If this fails to find `YourBox`,
executed on your LAN the command `sudo netdiscover -c 3 -s 10 -L -N -r 192.168.1.0/24`
and found the IP address, for example `192.168.1.154`.
Now try the command `ssh user-name@92.168.1.154` and if this does not work,
you need to install & configure SSH as shown below:

```bash
# update the systems repositories
sudo apt update && sudo apt upgrade

# install openssh server and uncomplicated firewall tool
sudo apt -y install openssh-server ufw

# enable ssh services to start on boot
sudo systemctl enable ssh

# verify ssh service status
sudo systemctl status ssh

# configure firewall
sudo ufw allow ssh
sudo ufw enable
```

I rebooted `YourBox` and redoing the command `ssh user-name@YourBox.local` to validate that it now works.
I can now remove the  monitor / keyboard / mouse from `YourBox`
and put it on my network via an Ethernet cable.
Going forward, I'll use a terminal to log into the `YourBox` environment
and all command-line and GUI / X-Windows program should work over this connection.

#### Step X: Check if X Windows is Running - DONE
I may want to run a X Window System (X11) application on `YourBox`
but display its graphical output on a remote client (e.g. my `desktop` with Ubuntu) which is also running X Window.
To do this, you need to use [SSH with X11 forwarding][09].
You must have X11 forwarding enabled on both the client side and the server side.
Also, you have to enable X11 forwarding when connecting via SSH,
and specify the clients `DISPLAY` environment variable.
This should all default properly and just work, but lets check by doing the following:

```bash
# from the client, shh into the server using x forwarding
ssh -X user-name@YourBox.local

# install your test apps on your remote system
sudo apt -y install x11-apps 

# check if you can remotely execute a x windows application on the server and display on your client
xclock &
xeyes &

# check if your running display server xorg or wayland - good thing to know if you need to debug
ps aux | grep xorg
ps aux | grep Xwayland
```

There are alternative to X11 Forwarding.
You can also use a remote desktop protocol like RDP (using [`xrdp`][07]) or [VNC][08]
to display an entire desktop on a remote client.
These protocols provide a more complete remote desktop experience compared to X11 forwarding,
which focuses on forwarding individual applications.

Sources:

* [How to Use X11 Forwarding on Windows or Linux](https://www.youtube.com/watch?v=FlHVuA_98SA)
* [How to forward X over SSH to run graphics applications remotely?](https://unix.stackexchange.com/questions/12755/how-to-forward-x-over-ssh-to-run-graphics-applications-remotely)
#### Step X: Install Packages for Frequently Used Linux Tools - DONE
While you may not need everything in the  `.dotfiles` directory,
these are all the software packages that are relevant to the dotfiles.
Install them all so if/when you need to use the `.dotfiles` tools,
you'll have them ready for use.

```bash
# update the packages on your system
#sudo apt update && sudo apt upgrade && sudo apt dist-upgrade     # run package upgrades that require installing or removing some other package   
sudo apt update && sudo apt upgrade                              # upgrade all packages without removing any (safe upgrade)

# install packages for general use
#sudo apt -y install trash-cli gnome gnome-session gnome-terminal git jq vim tmux wmctrl curl stow xclip     # this installs gnome GUI
sudo apt -y install trash-cli gnome-terminal git jq vim tmux wmctrl curl stow xclip gawk                         # this is without the gnome GUI 

# install basic networking tools
sudo apt -y install net-tools nmap traceroute arp-scan netdiscover

# packages which let apt get packages over HTTPS
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common

# install tools required by ansible
sudo apt -y install sshpass lookup acl

# install codecs for proprietary files with restricted copyright
sudo apt -y install ubuntu-restricted-extras

# install some tools used for my custom neovim configuration
sudo snap install alacritty --classic
sudo snap install nvim --classic            # this may not install well
sudo apt -y install wl-clipboard            # if your using X Window's Wayland protocol (other wise install 'xset')
sudo apt -y install ripgrep                 # ripgrep (executable is called `rg`) is need by for telescope

# install terminal emulator alacritty with apt
sudo apt -y install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 cargo
sudo apt -y install alacritty
```

#### Step X: Install Your `.dotfiles` - DONE
Within my GitHub, I maintain my `.dotfiles`` and the maintenance tool that I use is `stow`.
Let's pull down the latest`.dotfiles` repository and an install anything required:

```bash
# make sure you have install your version of the .dotfiles
cd $HOME
git clone https://github.com/jeffskinnerbox/.dotfiles.git

# the environment variable for the path to `.config` directory, this will be put into your '.bashrc' file
export XDG_CONFIG_HOME=$HOME/.config

# remove any files that will conflict with the 'stow' operations that comes next 
trash .bashrc .bash_logout

# stow all your dotfile package - aka create your symlinks for your configuration files
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-X
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-vim
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-tmux
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-bash
stow --dir=$HOME/.dotfiles --target=$HOME --stow pkg-screen
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-nvim
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-yamllint
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-alacritty
stow --dir=$HOME/.dotfiles --target=$XDG_CONFIG_HOME --stow pkg-ansible-lint
```

Now restart your Bash shell to gain access to your you just installed:

```bash
# apply changes you make to your .bashrc file in your current shell session 
source ~/.bashrc

# you'll see an error concerning `conda` but this will be fixed in the next step.
```


#### Step X: Install Miniconda for Python and NVM Version of Node.js - DONE
[Python][67] is such a success in large part because of its very active community
in which people share their awesome solutions.
Unfortunately, there is a price.
[Python packages][68] you used get updated with a better way to solve their problem.
These changes can be breaking changes for the code you have written.

There are several ways to deal with this issue and I have chosen to manage it by using
[Miniconda][70], a much smaller base installation than [Anaconda][69],
but with the ability to scale up to the whole Anaconda distribution, if you chose to do so.
The Miniconda Python system requires ~400MB of disk space, where Anaconda requires ~3GB of disk space

The following steps install Miniconda.
Not only will Miniconda will be installed but your `bash` shell environment
(specifically the files `.bashrc` or `.bash_profile`)
will be updated to include Miniconda in the `$PATH`.
Also, if the environment variable `$PYTHONPATH` is set, you will get a warning like
"*please verify that your $PYTHONPATH only points to directories of packages that are compatible with the Python interpreter in Miniconda3*"

```bash
# create a directory to install miniconda in
cd $HOME
mkdir -p ~/.miniconda3

# determine the processor architecture of your Linux system
$ uname -m
x86_64

# download latest miniconda version - https://repo.anaconda.com/miniconda/
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -O ~/.miniconda3/miniconda.sh

# run the install script
bash ~/.miniconda3/miniconda.sh -b -u -p ~/.miniconda3

# delete the install script
rm -rf ~/.miniconda3/miniconda.sh
```

Following the steps above, restart the terminal and Miniconda is ready to go.

```bash
# restart your terminal

# add a conda initialize to your bash   <-- DO NOT run `conda init bash` if you plan to use `~/.dotfile` since it already contains the changes needed for `~/.bashrc`
#~/.miniconda3/bin/conda init bash

# verify the installation by listing the contents of the install
conda list

# list the environments established (should only be 'base')
conda env list
```

There are at least two ways to install Node.js.
You could do it via a Ubuntu repository package,
but a superior way is to using [Node Version Manager (`nvm`)][48]
along with the [Node Package Manager (`npm`)][47].
Now let's install the [Long Term Support (LTS)][49] version of [Node.js][50].

```bash
```bash
# download and install node version manager (nvm) - https://nodejs.org/en/download
cd $HOME
mkdir $HOME/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"      # in lieu of restarting the shell
nvm install 24              # download and install node.js LTS version 24

# verify the node.js version
$ node -v
v24.1.0

# verify the node version manager (nvm) version
$ nvm current
v24.1.0

# verify node package manager (npm version
$ npm -v
11.3.0
```


#### Step XB: If You Wish to Uninstall Miniconda - DONE-NOT
To uninstall Miniconda, you follow these steps:

```bash
# backup any important data and python environments
conda env export > environment.yml

# locate miniconda directory and delete it
ls -a ~ | grep miniconda
rm -rf ~/.miniconda3

# remove conda configuration files (optional)
rm -rf ~/.condarc ~/.conda

# open file editor and remove miniconda path from .bashrc or .bash_profile
#    open the file in a text editor, find the line that contain
#    references to miniconda and remove them
```

Sources:

* [How to Uninstall Miniconda on Linux: A Guide](https://saturncloud.io/blog/how-to-uninstall-miniconda-on-linux-a-guide/)
* [Install Miniconda on Linux from the command line in 5 steps](https://javedhassans.medium.com/install-miniconda-on-linux-from-the-command-line-in-5-steps-403912b3f378)

#### Step X: Install Nerd Fonts - DONE
Ubuntu bundled its own fonts,
and they are all Free Libre Open Source Software licensed (FLOSS).
The fonts included by default in Ubuntu are of course different to other operating systems.
On Ubuntu, fonts installation is located in two places:
User fonts - `~/.local/share/fonts/` and System fonts - `/usr/share/fonts/`.

The terminal version of NeoVim, we will use whatever font your terminal is using.
So to implement your preferred font,
you’ll need to change the font of your terminal emulator.
In my case, the terminal emulators I use are [`gnome-terminal`][51] and [`alacritty`][52].

Nerd Fonts is a project that patches developer-targeted fonts with many [glyphs][54] ([icons][55]).
It includes [programming ligatures][56] and is designed to enhance the appearance of source code.
Nerd Fonts also includes additional broad range of glyphs giving geeks more eye candy.

```bash
# list all the available fonts
fc-list

# check if any nerd fonts are already installed
fc-list | grep -i nerd
```

Now lets install the tool, [getNF (aka `getnf`)][58],
we'll use to load Nerd Fonts on our system:

```bash
# cloning the nerd fonts installation tool 'getnf'
mkdir ~/src
cd ~/src
git clone https://github.com/ronniedroid/getnf.git
cd getnf
./install.sh
```

To find a font that you find appealing,
check out [programmingfonts.org](https://www.programmingfonts.org/)
and [CodingFont](https://www.codingfont.com/).

Make sure that `~/.local/bin` is in your PATH so that `getnf` is executable.
Now to install the fonts,
we'll run `getnf` and select from the menu what fonts to install.
Choose one or more fonts (by index/number) to install
Hit Return/Enter to install the selected fonts.
Type the index/number corresponding to 'Quit' to cancel.

```bash
# you can load fonts from your home directory
cd $HOME

# read the getnf help information
getnf --help

# using `gitnf`, install the following fonts: JetBrainsMono
getnf

# check if the nerd fonts have been added
ls ~/.local/share/fonts

# clean-up from getnf, if needed
trash ~/JetBrainsMono.tar.xz
```

At this point, you'll need to restart your X Windows desktop manager so the `gnome-terminal`
application picks up the change.
There will only be a change if your running a Gnome GUI desktop environment.
With that, within a `gnome-terminal` window,
click the "hamburger" menu > **Preferences** > **Default** > select your Nerd Font.
I selected `JetBrainsMonoNL Nerd Font Mono` and font size `9`.
See "[Our favorite fonts for the Linux terminal][57]" for more information.

Once the font files are copied to these locations,
you need to refresh system wide font cache to complete the installation.
To do so, run the following command:

```bash
# refresh system wide font cache to complete the installation
sudo fc-cache -vf ~/.local/share/fonts
```

The fonts in `~/.local/share/fonts` are available for all apps now.

Using the command-line on the GTKtec M6 client,
execute `gnome-terminal` and `alacritty` to make sure they pop-up a window logged into the client:

```bash
# execute terminal sessions and make sure these new windows pop-up on your server but logged into you client
alacritty         # this worked nicely
gnome-terminal    # you need a gnome GUI to see the effects
```

Sources:

* [How to Install Nerd Fonts on Linux](https://bytexd.com/how-to-install-nerd-fonts-on-linux/)
* [How to Install Nerd Fonts on Linux](https://www.geekbits.io/how-to-install-nerd-fonts-on-linux/)
* [Nerd Fonts](https://www.nerdfonts.com/#home)
* [GitHub: ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
* [Add Icons to your Fonts with Nerd Fonts](https://www.youtube.com/watch?v=fR4ThXzhQYI)
* [Neovim 101 — Fonts](https://alpha2phi.medium.com/neovim-101-fonts-da575bd4eda9)
* [Installing system nerd-fonts with ansible](https://waylonwalker.com/ansible-install-fonts/)
    * [No More Missing Fonts | ansible-playbook](https://www.youtube.com/watch?v=2MEmsinxRK4)


#### Step 5B: Uninstall Nerd Fonts - DONE, NOT
To remove fonts installed on User directory:
Go to `~/.local/share/fonts/` and delete the files with `.ttf` or `.otf` extensions.
Repeat this step for each of the targeted fonts.






















---------------


# Install Your $HOME/.dotfiles


#### Step 1: Install Stow - DONE
Very first step is to install Stow on your machine:

```bash
# install stow
sudo apt install stow
```


#### Step 2: Create Your ~/.dotfiles-test Directory for Testing - DONE
As a first step, before I do anything serious,
I'm going to create my initial .dotfile for testing and call it `~/.dotfiles-test`.

```bash
# make your .dotfiles directory and test package directory
mkdir -p ~/.dotfiles-test/pkg-nvim

# make your test directory system & file witihin ~/.dotfiles-test/nvim
# just as you might expect it to appear in your planned target
mkdir -p ~/.dotfiles-test/pkg-nvim/nvim/lua/active/configs
mkdir -p ~/.dotfiles-test/.git
touch ~/.dotfiles-test/README.md
touch ~/.dotfiles-test/.gitignore
touch ~/.dotfiles-test/pkg-nvim/README.md
touch ~/.dotfiles-test/pkg-nvim/nvim/README.md
touch ~/.dotfiles-test/pkg-nvim/nvim/lua/README.md
touch ~/.dotfiles-test/pkg-nvim/nvim/lua/active/README.md
touch ~/.dotfiles-test/pkg-nvim/nvim/lua/active/init.lua
touch ~/.dotfiles-test/pkg-nvim/nvim/lua/active/configs/README.md
touch ~/.dotfiles-test/pkg-nvim/nvim/lua/active/configs/tokyonight.lua

# inspect ~/.dotfiles-test to assure it is correct
ls -al ~/.dotfiles-test
```


#### Step 3: Create Your Target for Testing - DONE
The target directory for your Stow update could be an existing directory.
In many case that might be `$HOME/.config`.
I'm going to simulate that case here:

```bash
# create a pre-existing ~/tmp/.config directory just like you would typical see in $HOME
mkdir ~/tmp/.config

# inspect ~/tmp
ls -al ~/tmp
```

There will exist files under the `.dotfiles` package directories
which do not want to stow into the target directory
(files & directories like `.git`, `.gitignore`, `README.md`, etc.).
It happens to be that Stow automatically ignores these but if you want your own ignore list,
you can enforce this by including within `.dotfiles-test` the file `.stow-local-ignore`
(documentation for this file can be found [here][02]).

Now I will create the required symlinks to my target location `~/tmp`:

```bash
# create a test directory
mkdir $HOME/tmp/test-config

# first ... test/simulate stow package creation of nvim configuration files
stow --simulate --verbose=5 --dir=$HOME/.dotfiles --target=$HOME/tmp/test-config --stow pkg-nvim

# stow nvim package - aka create your symlinks for your nvim configuration files
stow --dir=$HOME/.dotfiles --target=$HOME/tmp/test-config --stow pkg-nvim

# inspect what you have just created
ls -al ~/.dotfiles
ls -al ~/tmp/test-config

# undo / remove your stow creation
stow --dir=$HOME/.dotfiles --target=$HOME/tmp/test-config --delete pkg-nvim

# inspect what you just removed
ls -al ~/tmp/test-config
```


#### Step X: Create Your .dotfiles Directory
NeoVim directory within .docfiles

using `tree -a --filesfirst ~/.dotfiles/pkg-nvim/`

```
/home/jeff/.dotfiles
└── pkg-nvim
    └── nvim
        ├── init.lua
        └── lua
            ├── active
            │   ├── autocommands.lua
            │   ├── init.lua
            │   ├── keymappings.lua
            │   ├── plugins.lua
            │   ├── settings.lua
            │   └── configs
            │       ├── bufferline.lua
            │       ├── comment.lua
            │       ├── indent-blankline.lua
            │       ├── lualine.lua
            │       ├── nvim-tree.lua
            │       ├── nvim-web-devicons.lua
            │       ├── telescope.lua
            │       ├── toggleterm.lua
            │       ├── tokyonight.lua
            │       └── whichkey.lua
            ├── editor-basic
            │   ├── autocommands.lua
            │   ├── init.lua
            │   ├── keymappings.lua
            │   ├── plugins.lua
            │   └── settings.lua
            └── editor-enhanced
                ├── autocommands.lua
                ├── init.lua
                ├── keymappings.lua
                ├── plugins.lua
                ├── settings.lua
                └── configs
                    ├── barbar.lua
                    ├── bufferline.lua
                    ├── comment.lua
                    ├── dracula.lua
                    ├── lualine.lua
                    ├── material.lua
                    ├── neo-tree.lua
                    ├── nightfox.lua
                    ├── nvim-tree.lua
                    ├── nvim-web-devicons.lua
                    ├── toggleterm.lua
                    └── tokyonight.lua
```

```bash
# test the stow and then check
stow --dir=$HOME/.dotfiles --target=$HOME/tmp/.config --stow pkg-nvim

# do the stow for real
stow --dir=$HOME/.dotfiles --target=$HOME/.config --stow pkg-nvim
```


#### Step X: vim

```bash
#  move to the package directory related to vim
cd ~/.dotfiles/vim-pkg

# update the stow ignore file
cp ~/.dotfiles/stow-local-ignore .stow-local-ignore

# test the stow and then check
stow --dir=$HOME/.dotfiles --target=$HOME/tmp/test-vim --stow vim-pkg

# do the stow for real
stow --dir=$HOME/.dotfiles --target=$HOME --stow vim-pkg
```


#### Step X: xxx

```bash
git init .
git add mydotfile
git commit -m "Create dotfiles repository"
```




[01]:https://www.gnu.org/software/stow/manual/stow.html
[02]:https://www.gnu.org/software/stow/manual/stow.html#Ignore-Lists

[67]:https://www.python.org/
[68]:https://pypi.org/
[69]:https://www.anaconda.com/
[70]:https://www.anaconda.com/docs/getting-started/miniconda/main
