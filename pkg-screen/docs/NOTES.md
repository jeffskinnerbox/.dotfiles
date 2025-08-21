<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.2
-->

# Notes
In here are instructions on the creation, maintenance, and use of this repository
via [git][01] and [GitHub][02].  For more information, check out these posts:

* [Using Git and Github to Manage Your Dotfiles][03]
* [Managing dot files with Git][04]

====


### Creating the GitHub Repository
Goto your GitHub instance,
tnat is <https://github.com/jeffskinnerbox> ,
and create the new repository called `.screen`.

### Creating the Local Git Repository
Make the `~/.screen` directory, move into it, and initialize it as a git repository

    cd ~
    mkdir .screen
    cd .screen
    git init

Also create the file `.gitignore` like this:

    ### ---------- Project Specific ---------- ###


    ### ---------- General ---------- ###

    ### Compiled Source ###
    *.pyc
    *.com
    *.class
    *.dll
    *.exe
    *.o
    *.so

    ### Packages ###
    *.7z
    *.dmg
    *.gz
    *.iso
    *.jar
    *.rar
    *.tar
    *.zip

    ### Logs & Databases ###
    *.log
    *.sql
    *.sqlite

    ### OS Generated Files ###
    *.out
    *.swp
    .DS_Store
    .DS_Store?
    ._*
    .Spotlight-V100
    .Trashes
    Icon?
    ehthumbs.db
    Thumbs.db

Now commit the files to the git repository:

    git add --all
    git commit -m 'Initial creation of Screen resource file for Linux box'


### Loading the GitHub Repository for the First Time
Within the `~/.screen` directory, use git to load the files to GitHub

    git remote add origin https://github.com/jeffskinnerbox/.screen.git
    git push -u origin master

### To Update the Local Git Repository
Within the .screen directory, do a "get status" to see what will be included in the commit,
add files (or remove) that are required, and then do the commit to the local git repository.

    git status
    git add --all
    git commit --dry-run
    git commit -m <comment>

### To Update the Remote (i.e. GitHub) Repository
To which shows you the URL that Git has stored for the shortname to for
the remote (GitHub) repository:

    git remote -v

Now to push your files to the GitHub repository

    git push -u origin master

### To Clone .screen Environment on Another Machine
Login into the target machine and go to its $HOME
and clone the .screen environment by execute the following:

    cd ~
    git clone http://github.com/jeffskinnerbox/.screen.git ~/.screen
    ln -s ~/.screen/screenrc ~/.screenrc

### Upgrading Your .screen Directory From Remote GitHub Repository

    cd ~/.screen
    ?????????? git pull origin master ???????????



[01]:http://git-scm.com/
[02]:https://github.com/
[03]:http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
[04]:http://blog.sanctum.geek.nz/managing-dot-files-with-git/
