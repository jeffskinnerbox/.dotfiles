<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      1.0.3
-->

# Notes
In here are instructions on the creation, maintentance, and use of this repository
via [git][01] and [GitHub][02].  For more information, check out these posts:
* [Using Git and Github to Manage Your Dotfiles][03]
* [Managing dot files with Git][04]

====

### Creating Your Local Git Repository
Store your existing .xbindkeysrc and .Xresources in the .X directory

    mv .xbindkeysrc ~/.X/xbindkeysrc
    mv .Xresources ~/.X/Xresources
    mv .xsessionrc ~/.X/xsessionrc
    ln -s ~/.X/xbindkeysrc ~/.xbindkeysrc
    ln -s ~/.X/Xresources ~/.Xresources
    ln -s ~/.X/xsessionrc ~/.xsessionrc

Change to the .X directory, and initialize it as a git repository

    cd ~/.X
    git init

Create a README.md file, add all the files, and make initial comment

    <make a README file>
    git add .
    git commit -m 'your initial commit'

### Creating the GitHub Repository
Goto GitHub and create the new repository

    goto https://github.com/jeffskinnerbox
    <create empty repository called 'dotX'>

### Loading the GitHub Repository for the First Time
Within the ~.X directory, use git to load the files to GitHub

    git remote add origin https://github.com/jeffskinnerbox/dotX.git
    git push -u origin master

### To Update the Local Git Repository
Within the .X directory, do a "get status" to see what will be included in the commit,
add files (or remove) that are required, and then do the commit to the local git repository.

    git status
    git add <files>   (or git rm <files>)
    git commit --dry-run
    git commit

### To Update the Remote (i.e. GitHub) Repository
To which shows you the URL that Git has stored for the shortname to for
the remote (GitHub) repository:

    git remote -v

Now to push your files to the GitHub repository

    git push -u origin master

### To Perform the Initial Replication of .X Environment on Another Machine
Login into the target machine and go to its $HOME

    cd ~
    git clone http://github.com/jeffskinnerbox/dotX.git ~/.X
    ln -s ~/.X/xbindkeysrc ~/.xbindkeysrc
    ln -s ~/.X/Xresources ~/.Xresources
    ln -s ~/.X/xsessionrc ~/.xsessionrc
    cd ~/.X
    git submodule init
    git submodule update

### Upgrading Your .vim Directory From Remote GitHub Repository

    cd ~/.X
    ?????????? git pull origin master ???????????



[01]:http://git-scm.com/
[02]:https://github.com/
[03]:http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
[04]:http://blog.sanctum.geek.nz/managing-dot-files-with-git/
