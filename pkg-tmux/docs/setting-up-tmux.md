
<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.0
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


-----




* What about [Sublime](https://www.sublimetext.com/) and [Atom](https://atom.io/) or
* [Supercharge JavaScript development in Atom](https://medium.com/@satya164/supercharged-javascript-development-in-atom-ea034e22eabc)


* [Tmux for mere mortals](https://zserge.com/posts/tmux/)
* [Terminal Multiplexer (TMUX)](https://www.youtube.com/playlist?list=PLQnZaivG_fPWQsFSwYbdtRqwIbI8yJae8)
* [tmux](https://www.youtube.com/playlist?list=PLTRNG6WIHETB4reAxbWza3CZeP9KL6Bkr)
* [A tmux Primer][10]
* [tmux Config: Understanding the Configuration File + Customization Examples][24]
* [Tmux has forever changed the way I write code](https://www.youtube.com/watch?v=DzNmUNvnB04)
* [A quick introduction to tmux](https://opensource.com/article/17/2/quick-introduction-tmux?sc_cid=701600000012072AAA)
* [A guide to Tmux that will increase your productivity](https://apiumtech.com/blog/tmux-cheat-sheet-tips-tricks/)
* [Use tmux to create the console of your dreams](https://opensource.com/article/20/1/tmux-console)
* [rxvt-unicode / urxvt](http://www.slant.co/topics/794/compare/~terminator_vs_rxvt-unicode_vs_gnome-terminal)
* [e3](http://manpages.ubuntu.com/manpages/xenial/man1/e3.1.html)
* [Editor Wars](http://hackaday.com/2016/07/26/editor-wars/) and the topic even has a [Wikipedia page](https://en.wikipedia.org/wiki/Editor_war#)
* [Top 7 open source terminal emulators](https://opensource.com/life/15/11/top-open-source-terminal-emulators?sc_cid=70160000001206EAAQ)

* [How to Use tmux for Remote & Local Development](https://deliciousbrains.com/tmux-for-local-development/)
* [How to Kill or Restart a tmux Pane](https://www.baeldung.com/linux/tmux-kill-respawn-pane)






[`tmux`][22] is a terminal multiplexer that allows us to create multiple sessions
that act roughly like terminal windows, create windows that act like tabs,
and create panes that let us split `tmux` windows horizontally and vertically.

Tmux is a really cool tool for the Linux admin.
It allows you to multitask or close out a session without it killing the terminal
so you can do backups or upgrade your system without having to leave a terminal open,
just type your command hit `Ctrl+b` then `d`, and walk away.

Tmux is what is called a multiplexer.
A multiplexer allows you to run multiple terminal sessions at once.
Or run a terminal session in the background.
This is useful when you need to access multiple ssh sessions at a time or just for a good general workflow.

# What is Tmux and Why Use it?
The tmux terminal multiplexer is often used in remote development, but it has interesting applications for local dev work as well.

The name “tmux” is a contraction of “terminal multiplexer.” This means you can open multiple split-views (panes) in a single terminal window, and each will function as its own independent terminal. They run visually, right next to each other, eliminating the need to open a new window.

It’s often thought of as a tool you use when working on a remote server, as it saves opening up multiple terminal (SSH) sessions to the machine when you’re trying to do a few things at once.

Maybe you’ve got a script you need to run that takes a while and at the same time you want to monitor its output to a log file with a command like tail -f. Perhaps all the while editing some other configuration files or scripts you’re getting ready to run next.

Normally you’d fire up three or more separate instances of your terminal application and SSH into the server with each one. With tmux you only need one SSH connection to the server.

The great thing about tmux is it allows you to have multiple panes open at the same time, each with their own shell running, but using the same, single SSH connection.
Not only that, you can also have multiple windows open at the same time, a bit like tabs with more panes in them.

A huge benefit of using tmux on a remote server is that if your internet connection should die for any reason, that tmux session just keeps on truckin’. Your long-running job that you just kicked off and forgot to nohup and background with stream redirection keeps on going too. Just tmux attach once your internet is back and you’ve SSH’d into the server again, with all the same panes and windows there waiting for you. You can even detach from your current session, log back in at another computer, and find it’s still running.

Why Use tmux Locally? Using tmux on a remote server means internet connection problems may interrupt your work, but they won’t interrupt the processes you’re running. Given that connection issues can’t stop me using the command line on a machine I’m sitting right in front of, why do I use tmux locally? The biggest advantage is that as soon as I start my terminal emulator, my preferred command line workspace is waiting and ready to go.

What Happens When You Reboot?
“Okay smarty pants, what happens when you reboot your machine and that tmux session dies? Where’s your nice comfortable multi-window workspace now?”
Let me introduce you to my very favorite tmux plugins, [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) and [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum).

* **Background Operations -**
You can detach a tmux session from a client (the terminal) and you can attach it back later.
Therefore you can run whatever you want in the background, even if you have killed your terminal.
The Tmux session continues to run, doing its job.
* **Protection Against Terminal Crashes -**
Since your Tmux session is independent from your terminal,
you don’t need to worry anymore if you close it or even if it crashes.
You can always reattach your session afterward without any problem.
* **Saving Tmux Sessions -**
It’s possible to save Tmux sessions in a file and reopen them later,
even after switching off your computer.
* **More Terminals -**
With Tmux we can also create open multiple shell on a single screen.
Some terminals can do the same but Tmux consumes less resources and Tmux provides greater customization.
* **Remote Pair Programming -**
A Tmux session can be attached to many clients (terminals), even via SSH.
This means that you can do pair programming with another developer using Tmux and Vim,
by sharing the same session.

# Tmux
Like `screen`, `tmux` is a terminal multiplexer.
While technically screen and tmux serve the same purpose,
their functionality and quality differ.
Tmux lets you have multiple persistent terminal sessions and
come back to them without terminating the existing running processes.
So you can return to a workspace, exactly where you left it.
It also allows you to manage multiple windows and panes inside a session.

Development of screen started in 1987 resulting in a solid and proven piece of software.
On the other hand, the codebase isn’t clean nor easy to understand, and as a result,
development mostly has stopped and focus is on fixing critical bugs.
Tmux, on the other hand, started in 2007 and has learned from screen’s mistakes,
picking up existing and field-tested features, and is actively being developed.

* [tmux is sweet as heck](https://eev.ee/blog/2012/03/21/tmux-is-sweet-as-heck/)
* [A Quick and Easy Guide to tmux](http://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)
* [Making tmux Pretty and Usable - A Guide to Customizing your tmux.conf](http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/)
* [Why You Should Try tmux Instead of screen](http://cinchrb.org/posts/2010/10/tmux-vs-screen/)
* [.tmux.conf](https://www.rafaelhart.com/dotfiles/tmux-conf/)
* [How to make tmux count windows starting from 1 instead of 0?](http://unix.stackexchange.com/questions/35924/how-to-make-tmux-count-windows-starting-from-1-instead-of-0)
* [/howto/tmux](http://transitiontech.ca/howto/tmux)
* [The Tao of tmux](http://tmuxp.readthedocs.io/en/latest/about_tmux.html)

* [A tmux cheat sheet](http://alvinalexander.com/linux-unix/tmux-cheat-sheet-commands-pdf)
* [tmux & screen cheat-sheet](http://www.dayid.org/comp/tm.html)
* [Learn X in Y minutes](https://learnxinyminutes.com/docs/tmux/)














What about Byobu?
Byobu is a GPLv3 open source text-based window manager and terminal multiplexer. It was originally designed to provide elegant enhancements to the otherwise functional, plain, practical GNU Screen, for the Ubuntu server distribution. Byobu now includes an enhanced profiles, convenient keybindings, configuration utilities, and toggle-able system status notifications for both the GNU Screen window manager and the more modern Tmux terminal multiplexer, and works on most Linux, BSD, and Mac distributions.

* [How to use byobu to multiplex SSH sessions](https://opensource.com/article/20/2/byobu-ssh)
* http://byobu.co/

An integrated development environment (IDE) is a programming environment
that has been packaged as an application program,
typically consisting of a code editor, a compiler, a debugger,
and a graphical user interface (GUI) builder.

* [vim][14] highly customizable editor.
* [Terminator][01]

is a terminal emulator released under General Public License
and is available for GNU/Linux Platform.
The application program lets you use multiple splits and resized terminals,
all at once on a single screen.
The [configuration file][02] `~/.config/terminator/config`
is used to control options not in gnome-terminal `gconf` profiles, or override `gconf` settings.
    * [Getting the most out of Terminator][20]
* [iTerm2][09] is a replacement for the Mac's native Terminal.
As of this writing, it works only Macs, and like Terminator, does split screens, etc.
* [tmux][22] is a terminal multiplexer that allows us to create sessions
that act roughly like terminal windows, create windows that act like tabs,
and create panes that let us split tmux windows horizontally and vertically.
Since multiple people can connect to a tmux session at a time it gives us
the ability to pair on remote machines or even from separate locations.
These sites may  help in learning tmux:

* [Intro to Tmux][16]
* [A tmux Crash Course][13]
* [Beginner’s Guide to Tmux: Recommended Configuration, Plugins and Navigation Demo][15]
* TMUX – The Terminal Multiplexer, [Part 1][18] amd [Part 2][19]
* [Screen][04] is a full-screen window manager, with a [rich command set][21], that multiplexes a physical terminal
between several processes, typically interactive shells.
Each virtual terminal provides the functions of the DEC VT100 terminal and, in addition,
several control functions from the ANSI X3.64 (ISO 6429) and ISO 2022 standards
(e.g., insert/delete line and support for multiple character sets).

# Using the Right Font
* [Programming Fonts](http://programmingfonts.org/)
* [Programming Fonts Tester](http://app.programmingfonts.org/)



----



One of the best features of tmux is that you can go back to the normal command terminal and tmux will continue running in the background.

To control tmux, you need to press `Ctrl+B` every time you are going to enter a `tmux` command.
Some of the most common commands that you need to know about while using `tmux` are the following:

# How is Tmux Organized?
In Tmux, you will be working within a server controlling sessions, windows and panes.

* **Tmux Server** manages every single tmux session. If you kill it, you kill every session too. To do so, you can run the command `tmux kill-server`.
* **Sessions** define the general task at hand. For example, if you are testing something, stick to a single session for all activities related to your test.
By starting Tmux with the `tmux` command, you are starting a new session. The sessions are numbered by default, starting with 0.
You can detach sessions from a client (and let them run in the background), and re-attach them back again later.
* **Windows** are for specific activities or projects within a session and a window contains multiple panes.
A tmux window represent an entire screen. You can have multiple windows open in one session. These windows are represented by tabs in the tmux status bar, at the bottom. To switch from one window to another, you can use some keystrokes or even your mouse. More on that below.
* **Panes** help you create multiple views within one window. For example, you might be working something in one pane, and using the other to track error logs.
Panes are the part of a window where we run processes, commands, and scripts.
ou can split your windows in panes to have multiple shell on one screen.

# What is Tmux Workflow?
Sources:
* [Writing Your tmux Config: a Detailed Guide][27]
* [Everything you need to know about tmux – Plugins Manager][28]

## Tmux Keystrokes
Tmux is controlled via the keyboard, with a few mouse operations that are optional.
Keystrokes in Tmux need to be hit after hitting a prefix key.
default, this prefix key is `Ctrl+b`.
Tmux is controlled by pressing a prefix & key combination: `Ctrl+b`, followed by a hotkey.
If you think that the Tmux keystrokes are awkward and difficult to remember,
not a problem since they can be changed in a configuration file.
**NOTE:** Default prefix is `Ctrl+b` but I have changed mine to `Ctrl+s`
via these entries in the `~/.tmux.conf` file:

```bash
# within '~/.tmux.conf', change the control prefix from 'ctrl-b' to 'ctrl-s'
set -g prefix C-s
unbind C-b
bind-key C-s send-prefix
```

## Tmux Command Prompt
You can also execute special Tmux commands via a command prompt.
For example, you can:

* Enter `<prefix>`
* Enter `:`        (this gets you the 'Tmux Command Prompt' at the bottom of the window)
* Now, type `split-window` to create a pane.

You can execute many commands in tmux via some keystrokes or via this command prompt.

## Tmux Copy Mode
There are two modes within Tmux: "Default Mode" and "Copy Mode".
You can think of Copy Mode as the equivalent of the Insert Mode in Vim.
It allows you to type whatever you want in the different panes.
When you are in Copy Mode, you have the possibility to navigate in your terminal,
using Emacs or Vi key bindings.

The fundamental challenge with Copy Mode in Tmux is that its difficult to get
a consistent user experience of all the possible scenario.
The features of Tmux can cause the copy & paste workflow to be diffenent within Tmux
and between Tmux and external terminals, application like browser, etc.
(The referances [here][29], [here][33], [here][30], and [here][34] give you some hints of the complexities.)

Tmux can be confgured to supports mouse input,
which means you can use the mouse to select text and copy it to the clipboard.
There is a plugin call [tmux-yank][32] that provides a consistant user experience
by using the Linux system clipboard as a common way to exchange copy & paste text.

With the tmux-yank plugin,
I can do copy & paste with the following keys and mouse movements:

* **Copy & Paste Within Tmux**
    * **Copy Text -** Using the mouse, put cursor at beginning of text, hold down left-button,
    move over the text to be copied, and release button when done.
    This copies the text into the system clipboard.
    * **Paste Text -** Place cursor at the beginning of the point of insertion,
    and then press/release the center mouse button, aka the wheel.
    When the copy was done within Tmux, you can use the mouse.
* **Copy from Tmux / Paste into Outside Tmux**
    * **Copy Text -** Using the mouse, put cursor at beginning of text, hold down left-button,
    move over the text to be copied, and release button when done.
    This copies the text into the system clipboard.
    * **Paste Text -** Using the applications native paste to system clipboard methodology.
* **Copy from Outside Tmux / Paste into Tmux**
    * **Copy Text -** Using the applications native copy to system clipboard methodology.
    * **Paste Text -** Enter `<prefix> Cntl+v` and text will be inserted at the cursor location.
* **Copy & Paste Outside Tmux**
    * **Copy Text -** Using the applications native copy to system clipboard methodology.
    * **Paste Text -** Using the applications native paste to system clipboard methodology.

Sources:
* Tmux-Yank
    * [GitHub: tmux-plugins/tmux-yank][31]
    * [Video: Tmux Yank plugin](https://vimeo.com/102039099)
    * [Copy and Paste in tmux](https://www.seanh.cc/2020/12/27/copy-and-paste-in-tmux/)
    * [Tmux copy-paste mode tips and tricks for productivity][29]
    * [Why so hard?: Remote Tmux Copy/Paste][33]
* Other Method
    * [How to copy and paste with a clipboard in Tmux][30]
    * [How to copy and paste with a mouse with tmux][34]
    * [Tmux Documentation: The Clipboard](https://github.com/tmux/tmux/wiki/Clipboard)
    * [Enable vi-like copy paste in Tmux][35]









The commands below are the ones most commonly used.
[Tmux Cheat Sheet & Quick Reference](https://tmuxcheatsheet.com/)
[Tmux Cheat Sheet: Essential Commands And Quick References](https://www.stationx.net/tmux-cheat-sheet/)

**Tmux Help Screen**
* `<prefix> ?` to list `tmux` help screen. Press `q` key to exit.
**Tmux Plugin Management**
* `<prefix> I` to install new plugins from GitHub
* `<prefix> U` to update all installed plugins
* `<prefix> Alt+u` to update a specific installed plugin, you will be prompted to choose which plugin
* `<prefix> Alt+d` remove a specific installed plugin, you will be prompted to choose which plugin
* `<prefix> Alt+i` install a plugin, you will be will prompt to enter the GitHub repository
**Managing Tmux Sessions**
* `tmux` open `tmux` in your current terminal
* `tmux new` create a new session with the default number as its name
* `tmux new -s <session_name>` create a new session with a name
* `tmux rename-session -t <name> <new_name>` rename a current session
* `<prefix> $` replace the existing name with the desired name
* `<prefix> s` list all your Tmux sessions
**Query Sessions, Windows, Pane**
* `tmux ls` display a list of all the active tmux sessions
* `<prefix q` display pane number and dimensions of the pane
**Kill Active Session, Window, Pane**
* `<prefix> :kill-session` will kill the active session, all its windows and panes
* `tmux kill-session -t <session-name>`	closes the named session. **Note** that this is different from detaching from a session. Detaching from a session will leave processes running.
* `<prefix> :kill-window` or `<prefix> &` kill the active window and all panes within it
* `<prefix> :kill-pane` or `<prefix> x` kill the active pane
* `<prefix> :kill-session` this will kill your current Tmux session
* `tmux kill-server` to cleanly & gracefully kill all tmux open sessions (and server)
**Exit Tmux Pane**
* `exit ` like a Shell session, if you need to exit a `tmux` pane, just type `exit` and press Enter. Alternatively, press `Ctrl+d`, and the currently selected `tmux` pane will close.
**Respawn Active Session, Window, Pane**
* `<prefix> :respawn-window` will stop and restart a window, for an active window use the kill flag like `<prefix> :respawn-pane -k 1` (killing window one)
* `<prefix> :respawn-pane` will stop and restart a pane, for an active pane use the kill flag like `<prefix> :respawn-pane -k 1` (killing pane one)
**Navigating Between Vim Splits and Tmux Panes**
* `Ctrl-h` move curser to Left split/pane (Note: no `<prefix>` needed)
* `Ctrl-j` move curser to Down split/pane
* `Ctrl-k` move curser to Up split/pane
* `Ctrl-l` move curser to Right split/pane
* `Ctrl-\` move curser to Previous split
**Navigate & Existing Session and Windows**
* `<prefix> s` to switch sessions
* `<prefix> d` detach from a tmux session and go back to a normal shell session
**Transforming Windows and Panes**
* `<prefix> z` zoom into a pane so it takes up the whole terminal
* `<prefix> !` turn a pane into a window
**Navigate Existing Windows**
* `<prefix> c` to open a new `tmux` window
* `<prefix> x` to destroy the `tmux` window
* `<prefix> ,` rename the current window
* `<prefix> <window-number>` to switch to the `tmux` window number `<window-number>`
* `<prefix> n` move to the next window
* `<prefix> p` move to the previous window
* `<prefix> w` to switch between the `tmux`, display an interactive list of windows
* `<prefix> <window_number>` to go directly to a terminal window session
**Attach to / Detach from a Session**
* `tmux detach` detach yourself from the current working `tmux` session (`tmux` will continue running in the background)
* `tmux attach` go back to working on the `tmux` session
* `tmux attach-session -t 6` to attach to a specific session, reattached to session 6
* `tmux a -t <name_of_the_session>` attach yourself to the named working session
* `tmux a #` attaches to a numbered session. Replace `#` with the number of your session.
**Split Tmux pane**
* `<prefix> %` to split the pane horizontally
* `<prefix> "` to split the pane vertically
* `<prefix> ;` toggle between the current and previous pane
* `<prefix> x` close the current pane
**Moving Between Panes**
* `<prefix> o` go to the next pane
* `<prefix> q` to move to a random pane, this lists the panes available, then select the number of the pane
**Resize Panes**
* `<prefix> resize-pane -D` moves the boundary line for the pane downward. The bottom bar will change from green to yellow.
* `<prefix> resize-pane -U` moves the boundary line for the pane upward.
* `<prefix> resize-pane -R` moves the boundary line for the pane right.
* `<prefix> resize-pane -L` moves the boundary line for the pane left.
* `<prefix> resize-pane -U 10` moves the boundary line up 10 cells.
* `<prefix> resize-pane –t 2 --R 5` moves the boundary line 5 cells to the right.
**Zoom into Pane**
* `<prefix> resize-pane -Z` Zooming into a pane works just like maximizing a window in a graphical interface (GUI). This will expand the current pane. Use the same command to set it back to normal.
**Exit Tmux Session**
* `<prefix> kill-session` to completely end a session
**Exist Tmux Window**
* `<prefix> &` to close a `tmux` window. Closing all windows will cause `tmux` to exit.
**Tmux Messages**
* `<prefix> ~` show previous messages from tmux, if any
* `<prefix> :list-keys` provides a list of the key bindings

# Tmux Popup
* [Tmux Popup (Floating Window) - Linux TUI](https://www.youtube.com/watch?v=3TnTHR6lB7Y)
* [tmux](https://www.youtube.com/playlist?list=PLTRNG6WIHETB4reAxbWza3CZeP9KL6Bkr)

# Create a Layout for Tmux Launch
# Rebuilding Tmux Layers
While it also doesn’t preserve the pane contents,
we can save and rebuild our Tmux layout from a saved string:

**THIS DOESN'T WORK ... YET**"

```bash
# query for you session's layout
$  tmux list-windows -t 0
1: bash* (3 panes) [153x33] [layout e7db,153x33,0,0[153x8,0,0,0,153x24,0,9{122x24,0,9,1,30x24,123,9,2}]] @0 (active)

# now create another session with the same layout
tmux select-layout -t 1 'e7db,153x33,0,0[153x8,0,0,0,153x24,0,9{122x24,0,9,1,30x24,123,9,2}]'

# open this new session in a terminal
```

Check out
* [Tmux tile layout arranges 8 panes into 3x3 instead of 4x2](https://superuser.com/questions/1803835/tmux-tile-layout-arranges-8-panes-into-3x3-instead-of-4x2)
* [How to Kill or Restart a tmux Pane](https://www.baeldung.com/linux/tmux-kill-respawn-pane)
* [How to create a layout and run commands in at tmux launch?](https://stackoverflow.com/questions/34769672/how-to-create-a-layout-and-run-commands-in-at-tmux-launch)


-----



## Install Tmux Pluins

# Tmux Logging & Preserving Sessions
* [tmux – logging and preserving sessions](https://mdschreier.com/2018/03/01/tmux-logging-and-preserving-sessions/)
* [Trick tmux into auto-logging](https://nicokrieger.de/trick-tmux-into-auto-logging/)
* [How to capture the Tmux pane history](https://www.fosslinux.com/81224/capture-the-tmux-pane-history.htm)
* [How to Capture tmux Pane History](https://linuxhint.com/capture-tmux-pane-history/)



-----



#### Step 1: Install Tmux
* [How I Use Tmux With Neovim For An Awesome Dev Workflow On My Mac](https://www.youtube.com/watch?v=U-omALWIBos)
* [Maximize functionality with these tmux plugins & extensions](https://www.fosslinux.com/106797/maximize-functionality-with-these-tmux-plugins-extensions.htm)
* [See this example](https://github.com/dwmkerr/dotfiles/blob/main/tmux/tmux.conf)
* [See this example](https://github.com/josean-dev/dev-environment-files/blob/main/.tmux.conf)
* [See this example](https://github.com/nickjj/dotfiles/blob/master/.tmux.conf)
* [See this example](https://github.com/timtyrrell/dotfiles-chezmoi/blob/master/dot_tmux.conf)
* [See this example](https://gist.github.com/DevNerd/3236975)

```bash
# install the tmux package
sudo apt install tmux

# what version of tmux was installed
$ tmux -V
tmux 3.2a

# put into you '.bashrc' file the environment variable for the path to 'tmux.conf' file
export XDG_CONFIG_HOME=$HOME/.config
```

Like `vi`, `vim`, `nvim`, `emacs`, and other mature Linux programs,
`tmux` is extensible and allows third-party code (or plugins) to extend its features and capabilities.
THes plugins can be installed manually, or managed through a “plugin manager.”
The [Tmux Plugin Manager][25] (also known as `tpm`)
is designed to automatically manage the `tmux` plugins
and those plugins are [listed here][26].
By adding few lines into your `.tmux.conf` file,
you can easily activate plugins and extend the power of tmux beyond its default offering.

First, we need to clone TPM locally so we can use it to install other plugins automatically:

```bash
# clone tpm under the $XDG_CONFIG_HOME folder
git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
```

Now lets test `tmux` with the test configuration file defined below
(found in my `~/.dotfiles/tmux-pkg/tmux-test.conf`):

```bash
# install the test configuration file (IMPORTANT: tmux will not behave properly if this isn't done)
cp ~/.dotfiles/tmux-pkg/tmux-test.conf $XDG_CONFIG_HOME/tmux/tmux.conf
```

Execute `tmux`, and once it is up & running,
enter `<perfix> I` to install all the plugins listed in the configuration file,
and finally exit and restart `tmux`.

If this appears to run fine, install your  personalized configuration file that support your workflow.
Mine is found at `~/.dotfiles/tmux-pkg/tmux.conf`.

```bash
# create link to tmux configuration file (the modern way to manage dot files)
mkdir -p $XDG_CONFIG_HOME/tmux
trash $XDG_CONFIG_HOME/tmux/tmux.conf
ln -s ~/.dotfiles/tmux-pkg/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
```

Sources

* [Managing tmux plugins with tmux plugin manager](https://www.fosslinux.com/106799/managing-tmux-plugins-with-tmux-plugin-manager.htm)
* [Everything you need to know about tmux – Plugins Manager][28]
* [list of tmux plugins][26]

#### Step 1A: Update Tmux (Optional)
TPM will need to be updated periodically to fix bugs and add new features.
To update TPM, run the following command:

```bash
# update tpm
cd ~/.config/tmux/plugins/tpm && git pull
```

#### Step 1B: Uninstall Tmux (Optional)
I messed up my `tmux.conf` file several times before I got it right.
Even with a badly formed configuration file,
`tmux` will run and then without warning crash or freeze.
I had to remove the configuration file and rebuild it systematically to expose the root cause.

If you wish to uninstall `tmux`, do the following:

```bash
# put you existing tmux configuration in a safe place in case you need it
cp -r $XDG_CONFIG_HOME/tmux ~/tmp/tmux
trash $XDG_CONFIG_HOME/tmux
trash ~/.tmux ~/.tmux.conf

# uninstall the tmux package
sudo apt remove tmux
```

#### Step X: Creating Tmux Configuration File (`~/.config/tmux/tmux.conf`)
See `/home/jeff/.dotfiles/tmux-pkg/tmux.conf`

#### Step X: Install Tmux Plugins
```bash
# `<prefix> I` to install new plugins from GitHub
```

Because I plan to use this GitHib repository accross multiple location,
I want to pull the code for the plugins directly from their GitHub repository
and not from a `git clone ...` as will be done via the Tmux method above.
To do this, you need to do a `git submodule add ...`.
Specifically, you should do the following:

```bash
# you must be in a git repository to run a git command
cd ~/.dotfiles

# first we make the tmux plugin manager (tpm) a submodule plugin
git submodule add https://github.com/tmux-plugins/tpm.git ~/.dotfiles/pkg-tmux/.tmux/plugins/tpm
```

Now execute `tmux` and load the plugins identified in the `~/.tmux.conf` file
by entering `<prefix> <shift>I`.
You can then check to make sure the plugins hve bee loaded by
inspecting `ls ~/.dotfiles/pkg-tmux/.tmux/plugins`.

Sources:
* [Tmux Plugin Manager][25]
* [Tmux Plugin Manager: A Must-Have For Tmux Power Users](https://ostechnix.com/install-tmux-plugin-manager/)
* [Everything you need to know about tmux – Plugins Manager][28]
* [Solving “Fatal: Not A Git Repository” (Or Any Of The Parent Directories) Error](https://komodor.com/blog/solving-fatal-not-a-git-repository-error/)

#### Step X: Copy-Paste Between System and Tmux Clipboards
By default, tmux uses its clipboard for copying and pasting text within a session.
This means that users cannot paste text copied from tmux to an outside window.
To allow for this copy & paste, you can install on Linux [xclip][23]
and make some additions to you `tmux.conf` file.

Make this installation on you Linux system where `tmux` is being used:

```bash
# install xclip
sudo apt-get install xclip
```

Within your `tmux.conf` file, make this addition:

```bash
# Use xclip to copy and paste with the system clipboard
bind C-c run 'tmux save-buffer - | xclip -i -sel clip'                    # use '<prefix> cntl+c' to copy text
bind C-v run 'tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer'   # use '<prefix> cntl+v' to paste text
```

You will now be able to copy & paste text between `tmux` and the system clipboard.
Press the `<prefix> Ctrl+c`, xclip will capture the current tmux buffer.
When you want to paste the content, press the `<prefix> Ctrl+v`.

Sources
* [tmux Config: Understanding the Configuration File + Customization Examples][24]
* [Enable vi-like copy paste in Tmux][35]
* [Enable or Disable clipboard copy and paste in Tmux](https://debugpointer.com/linux/tmux-enable-disable-clipboard-copy-paste)
* [Enable or Disable mouse in Tmux](https://debugpointer.com/linux/tmux-enable-disable-mouse)



-------



# Practical Examples of Using Tmux

## Running a Long-Term Process
Let’s say we’re downloading a large file. We start our download in a Tmux session, detach it, and go about our business. If we want to check on it, we simply reattach and there’s our download, chugging along nicely.

## Collaborative Work
Tmux isn’t just a solo performer. It’s great for team efforts too. With shared Tmux sessions, multiple users can access and control a single session. It’s like pair programming, but on steroids!


[01]:http://gnometerminator.blogspot.com/?view=flipcard
[02]:http://manpages.ubuntu.com/manpages/jaunty/man5/terminator_config.5.html
[03]:https://www.youtube.com/watch?v=5r6yzFEXajQ
[04]:https://www.linode.com/docs/networking/ssh/using-gnu-screen-to-manage-persistent-terminal-sessions
[05]:
[06]:
[07]:
[08]:
[09]:https://www.iterm2.com/
[10]:https://danielmiessler.com/study/tmux/
[11]:
[12]:
[13]:https://robots.thoughtbot.com/a-tmux-crash-course
[14]:http://vim.wikia.com/wiki/Tutorial
[15]:https://www.codementor.io/tmux/tutorial/beginners-guide-to-tmux-navigating-and-configuring-your-tmux
[16]:http://code.tutsplus.com/tutorials/intro-to-tmux--net-33889
[17]:https://gitlab.com/gnachman/iterm2/wikis/TmuxIntegration
[18]:http://blog.hawkhost.com/2010/06/28/tmux-the-terminal-multiplexer/
[19]:http://blog.hawkhost.com/2010/07/02/tmux-%E2%80%93-the-terminal-multiplexer-part-2/
[20]:http://blog.al4.co.nz/2011/05/getting-the-most-out-of-terminator/
[21]:http://www.computerhope.com/unix/screen.htm
[22]:https://github.com/tmux/tmux/wiki
[23]:https://opensource.com/article/19/7/xclip
[24]:https://www.hostinger.com/tutorials/tmux-config
[25]:https://github.com/tmux-plugins/tpm
[26]:https://github.com/tmux-plugins/list
[27]:https://thevaluable.dev/tmux-config-mouseless/
[28]:https://arcolinux.com/everything-you-need-to-know-about-tmux-plugins-manager/
[29]:https://www.fosslinux.com/105809/tmux-copy-paste-mode-tips-and-tricks-for-productivity.htm
[30]:https://linuxhint.com/copy-paste-clipboard-tmux/
[31]:https://github.com/tmux-plugins/tmux-yank
[32]:https://tmux-plugins.github.io/tmux-yank/
[33]:https://www.vinnie.work/blog/2020-11-24-why-so-hard-tmux-copy-paste
[34]:https://unix.stackexchange.com/questions/318281/how-to-copy-and-paste-with-a-mouse-with-tmux
[35]:https://debugpointer.com/linux/tmux-vi-copy-paste
[36]:
[37]:
[38]:
[39]:
[40]:


