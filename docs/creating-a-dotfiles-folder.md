<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


* [Sync your .dotfiles with git and GNU #Stow like a pro!](https://www.youtube.com/watch?v=CFzEuBGPPPg)

* [Yet Another Dotfiles Manager](https://yadm.io/#)
    * [A Better Way To Manage Your Dotfiles | yadm](https://www.youtube.com/watch?v=lR1UihK82qg)
    * [Managing Dotfiles with YADM: The Easy Way](https://medium.com/@julius.dehner/how-i-manage-my-dotfiles-with-yadm-4cbdb0d35d34)
    * [Dotfile management with YADM](https://blog.dmichael.be/2021/02/19/Dotfile-management-with-YADM/)




* [Sync files across multiple devices with Syncthing](https://opensource.com/article/20/1/sync-files-syncthing)



* [The ultimate dotfiles setup](https://www.youtube.com/watch?v=-RkANM9FfTM)
* [Automating your Dotfiles with Ansible: A Showcase](https://www.youtube.com/watch?v=hPPIScBt4Gw)


------



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



----



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
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:

