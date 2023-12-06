<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.2
-->

# Screen Dotfiles
Screen is a terminal multiplexer,
meaning that it allows you to run several instances of programs out of one terminal window.
It can also maintain a persistent session, even when you aren’t connected,
so if you set it up on a server, you can connect, start a process, disconnect,
and return to it at a later date.

# Screen
GNU Screen is a terminal multiplexer, a software application that can be used to multiplex several virtual consoles, allowing a user to access multiple separate login sessions inside a single terminal window, or detach and reattach sessions from a terminal.
Each virtual terminal provides the functions of the DEC VT100 terminal and, in addition, several control functions from the ISO 6429 and ISO 2022 standards.

* [Using GNU screen with examples](https://linuxconfig.org/using-gnu-screen-with-examples)
* [How to check if I'm in screen session?](https://serverfault.com/questions/257975/how-to-check-if-im-in-screen-session)
* [GNU Screen Cheat Sheet](https://opensource.com/sites/default/files/gated-content/osdc_cheatsheet-screen-2021.4.14.pdf)
* [Screen User’s Manual](https://www.gnu.org/software/screen/manual/screen.html)
* [Screen Command: Set Baud Rate](https://www.cyberciti.biz/faq/unix-linux-apple-osx-bsd-screen-set-baud-rate/)
* [What are useful .screenrc settings?](https://serverfault.com/questions/3740/what-are-useful-screenrc-settings)

The `screen` program does not (as far as we know) provide an option for local echo
(to see what you are typing).
Screen assumes that character echo will be supplied at the far end, not your local host.
This can be a pain but `minicom` is an alternative that can provide local echo.

* [An introduction to GNU Screen](https://opensource.com/article/17/3/introduction-gnu-screen)
* [Linux tips for using GNU Screen](https://opensource.com/article/21/4/gnu-screen-cheat-sheet)


