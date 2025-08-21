<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      1.0.3
-->


* [Getting the Most Out of X Resources](http://www.linuxjournal.com/article/1154)
* [XTerm Color Names](https://critical.ch/xterm/)

# X Window System

<a href="https://en.wikipedia.org/wiki/X_Window_System">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="X Windows Client Server Architecture" alt="X architecture" src="/images/x-windows-client-server-architecture.png" width="210" height="356" />
</a>
The X Window System (commonly referred to as X Windows or just X or X11)
is a software system and network protocol that provides a basis for
graphical user interfaces (GUIs) and rich input device capability for networked computers.
X is the standard windowing system for both Unix and Linux.
X uses a client/server model,
but appears backwards when you first learn of X.
In X, it's the server that runs on the local machine (e.g. Linux desktop),
providing its services to the display based on requests from client programs
that may be running remotely (e.g. headless Raspberry Pi).
Within a X Window System, a client can also run locally.
The server also manages the input devices (your keyboard and mouse),
and it manages the display of colors and fonts on the screen, all based on requests from a client.

One of the most significant features of X is that it was
specifically designed to work across a network.
The client and the server communicate via the X Protocol,
a network protocol that can run locally or across a network.
Regardless of whether a client program is local or remote,
it communicates with the server through the X Protocol.

Another feature of X is that absolutely everything
is configurable just by editing an ASCII file!
For example, in MS-Windows you CANNOT change the way the keyboard input is associated with a window.
(You HAVE to click the left mouse button in the window, and that ALWAYS makes the window "come to top".)
In X you can choose from about six different schemes!
Even the menus are configurable - including those for the window manager!

# Getting to Know Your X Environment

 <a href="http://en.wikipedia.org/wiki/X_Window_System">
    <img class="img-rounded" style="margin: 0px 8px; float: left" title="The X Window System (X11, X, and sometimes informally X-Windows) is a windowing system for bitmap displays, common on UNIX-like operating systems. X provides the basic framework for a GUI environment: drawing and moving windows on the display device and interacting with a mouse and keyboard. X does not mandate the user interface, this is handled by individual programs." alt="X Logo" src="/images/x-logo.png" width="100" height="100" />
</a>
The beauty of X is the flexibility it gives you in creating a graphics applications
and distribute them across a network.
On the other hand, this flexibility creates its own complexity
and makes it challenging to understand how X operates.

To clarify this, a typical X Window System consists of the following components and terminology:
<a href="http://en.wikipedia.org/wiki/X_Window_System_protocols_and_architecture">
    <img class="img-rounded" style="margin: 0px 8px; float: right" title="X Window Client Server Architecture" alt="X Architecture" src="/images/x-windows-client-server-architecture.png" width="210" height="356" />
</a>

* **X Window System (aka X, X11, X-Windows)** - [X Window System][38] provides the basic [framework, primitives, and protocals][42] for a graphical user interface (GUI) environment.  X does not mandate the user interface — this is handled by individual programs.  As such, the visual styling of X-based environments varies greatly; different programs may present radically different interfaces.  There are several implementation of X, including [X.Org][40], [XFree86][39], [Cygwin/X][41], and many more.
* **X Server (aka X Display Server)** - This creates the graphical environment on a graphical display device using the X Display Protocol.  An X Server program runs on a computer with a graphical display and communicates with various X client programs, along with peripherals like the keyboard and mice. Examples of X servers are [Xming][59] and [XServer][60].
* **X Client (aka X Application)** - An X client is an application program that displays on an X Server but which is otherwise independent of that server.  X Clients are built using software libraries that support the X Window System framework.
* **X Window Manager** - The Window Manager perfroms the tasks of managing how you interact with your application windows. Window Manager's are often designed to be highly customizable via configuration files.  The Window Manager takes care of deciding the position of windows, placing the decorative border around them, handling icons, handling mouse clicks outside windows (on the “background”), handling certain keystrokes, etc.  Examples are [WindowMaker][56], [sawfish][57], and [fvwm][58].
* **X Session Manager** - The session Manager automatically starts a set of applications, setting up, and restoring a working desktop environment.  More precisely, it is the set of applications managing these windows and the information that allow these applications to restore the condition of their managed windows if required.  The X session manager saves and restores the state of sessions.
* **X Display Manager (aka Login Manager)** - This program shows the graphical login prompt in the X Window System.  This is the first X program run by the system if the system (not the user) is starting X and allows you to log on to the local system, or network systems.  More generally, a Display Manager runs one or more X Servers on the local computer and accepts incoming connections from X Servers running on remote computers.  The local servers are started by the Display Manager, which then connects to them to present the user the login screen.
* **Desktop Environment** - A desktop environment such as [LXDE][61], [XFCE][62], [KDE][63], [GNOME][64], or Ubuntu's [Unity][65] are a suite of applications, fonts, icons, configuration files, and design patterns used to integrate all the above X Window System components to provide a consistent user experience. Display Environments typically provide a handful of applications bundled together to accomplish tasks in a graphical manner as opposed to using the command line. They often come with a desktop shell, which is a place to hold your fancy shortcut icons, as well as other tools such as file managers.
* **X Client** - An X client is simply a program which does all its screen, keyboard and
mouse handling via an X server.
Programs such as `xterm',`xedit', `xman' and`xclock' are all X clients;
these and many other X clients are distributed free with X.
Since their C sources are available,
they serve as examples of how to write X programs.
They range from toys such as `xeyes`, through the noddy editor `xedit',
to`xterm' which is the most useful X client
as well as one of the most powerful ones in the standard distribution.
* **X Protocol** - The X protocol is used for all communication for between X
clients and X servers.
Coders do not need to know about this -
they simply use calls to functions in a C library.
* **X Terminal** - Thi is a terminal which acts as a complete X server.
They plug straight into a network and use the X protocol directly,
typical cost less than a full workstation but give workstation quality graphics.
Because they are diskless, X terminal networks are easier and cheaper to maintain than
PC networks.
* **X Terminal Emulator** - This is a program which makes a PC pretend to be a low
quality  X terminal.
Vista/Exceed is one of the most popular X terminal emulators.

For my Linux desktop X Window System,
I'm running Lightweight X11 Desktop Environment (LXDE) which has `lxdm`
as its X Display Manager (aka GUI Login Manager),
and uses `lxsession` as it X Session Manager,
and the Metacity or `i3` X Window Manager.

Given all this, starting an X session is typically done in one of two ways:

1. The X session is started via a [X Display Manager][27], which provides the user login prompts on a GUI screen. In this case, the [Xorg][49] process is started at boot time along with the X Display Manager.
2. If Xorg wasn't started at boot time, the user starts X manually after logging in to a text console. This is typically done with the [`startx`][66] command, which is a simple shell script wrapper for [`xinit`][67].

<a href="http://en.wikipedia.org/wiki/X_display_manager_(program_type)">
    <img class="img-rounded" style="margin: 0px 8px; float: right" title="In the X Window System, the X server runs on the computer in front of the user. The X server may connect to a display manager running on another computer, starting a session which may comprise a variety of programs running on that other computer." alt="X Display Manager Pic" src="http://upload.wikimedia.org/wikipedia/commons/1/16/Xserver_and_display_manager.svg" width=25% height=25% />
</a>
In either case, X runs with root privileges since it needs raw access to hardware devices.
In the X Window System,
the X Display Manager runs as a program that allows the starting of a session
on an X Server from the same or another computer.
A Display Manager presents the user with a login screen which prompts for a username and password.
A session starts when the user successfully enters a valid combination of username and password.
The X Display Manager function was established, in part, to support standalone X Terminals.

A Display Manager can run on the local computer where the user sits or on a remote one.
When local, the Display Manager starts one or more X Servers,
displaying the login screen.
When the Display Manager is remote, the Display Manager works according to the
[X Display Manager Control Protocol (XDMCP)][52][^E].

[^E]:
    XDMCP is inherently insecure as it does not encrypt your traffic.
    Therefore, only use XDMCP on a wired network that you you trust or a solidly secure wireless network.
    Also, consider using alternatives that feature security (and often compression) such as [FreeNX][35].
    XDMCP also uses a large amount of bandwidth because it uses no compression.
    A 100Mb network may be necessary.
    However, the lack of compression can make XDMCP provide very fast graphics when the bandwidth is available.

The XDMCP protocol mandates that the X Server starts autonomously and connects to the Display Manager.
You configure an XDMCP Chooser program running on the local computer (or X Terminal)
to connect to a specific remote X Display Manager
or to display a list of suitable hosts (if configured to do so) that the user can choose from.
When the user selects a host from the list,
the XDMCP Chooser running on the local machine will send a message
to the selected remote computer's Display Manager
and instruct it to connect the X Server on the local computer or terminal.

Note that unlike [vncviewer][31], which just duplicates a hosts current screen on a remote system,
XDMCP allows several different users to login and run different X sessions at the same time.
Your not sharing a desktop screen image, your starting seperate X Window session on the remote machine.

If your Linux box boots into a graphical login screen, like my Ubuntu desktop system,
you are already running a Display Manager.
Specifically, my desktop Linux box is using [`lightdm`][68] as its X Display Manager.
You can determine this by running `cat /etc/X11/default-display-manager`
or `ps -A | grep dm`.
On the other hand, when I install TCL on the vintage laptop, you see no graphical login screen.
So you know that TCL isn't using a X Display Manager.

For my [desktop Linux environment][43], I'm using Ubuntu's default environment.
That is the [Unity Lightweight X11 Desktop Environment (LXDE)][61].
It consists of:

* **Window Manager** - [Openbox][50], the default window manager of LXDE
* **Display Manager** - [LXDM][51] is the Display Manager for LXDE
* **Session Manager** - [LXSession][37] is the standard session manager used by LXDE and it's desktop-independent and can be used with any Window Manager.

What is happening when you start up Unity on the desktop system and [run X][53]?
The following is an abbreviated [summary of startup activites][44].

1. The kernel starts the `init` process as process number 1, and it is responsible for starting all other processes.
1. `init` starts the LXDE Display Manager `/usr/sbin/lightdm` fairly late in the init process (the system dbus, filesystem and the graphics display system all must be ready).
1. `lightdm` creates an xauthority file and then starts X, starting it on virtual terminal 7
1. The `unity-greeter` get's the names of potential Window Managers, and in my case that would be `ubnutu` and so it uses  `/usr/share/xsessions/ubuntu.desktop`.
1. Once logged in, the files from `/usr/share/xsessions/ubunutu.desktop` now determine the rest of the startup sequence.
1. The `/usr/sbin/lightdm-session` shell script is run with the arguments `gnome-session --session=ubuntu`
1. `/usr/sbin/lightdm-session` then runs `$HOME/.profile`, loads `$HOME/.Xresources`, `$HOME/.Xmodmap`, runs scripts in `/etc/X11/xinit/xinitrc.d`, runs the Xsession scripts in `/etc/X11/Xsession.d/*`, using the options in `/etc/X11/Xsession`.options.
1. `lightdm-session` starts a Window Manager, or for Unity, starts the `gnome-session` Session Manager. The Window Manager uses the Unity `/usr/share/xsessions/ubuntu.desktop` configuration file.
1. `gnome-session` starts the specified program from `/usr/share/gnome-session/sessions/` and starts applications from `~/.config/autostart/` and `/etc/xdg/autostart`.

## The Display

It is important to remember that the X server is the is the software program which manages the monitor,
keyboard, and pointing device.
In the X window system, these three devices are collectively referred to as the "display".
Therefore, the X server serves displaying capabilities, via the display,
to other programs, called X clients, that connect to  the X server.
All these connections are established via the X protocol.

The relationship between the X server and the display are tight,
in that the X server is engineered to support a specific display (or set of displays).
As a user of X, you don't have any control over this relationship,
only the software developer who created the server can modify this relationship (generally speaking).
On the other hand, as a user you have free hand in configuring the
X protocol connection between the X server and the X clients.

How do you establish a X Protocol connection between any given server and a client?
This is done via the environment variable `DISPLAY`.
A Linux environment variable DISPLAY tells all its X clients what
display they should use for their windows.
Its value is set by default in ordinary circumstances,
when you start an X server and run jobs locally.
Alternatively, you can specify the display yourself.
One reason to do this is when you want log into another system,
and run a X client there, and but have the window displayed at your local terminal.
That is, the DISPLAY environment variable must point to your local terminal.

So the environment variable `DISPLAY` stores the address for X clients to connect to.
These addresses are in the form: `hostname:displaynumber.screennumber` where

* `hostname` is the name of the computer where the X server runs. An omitted `hostname` means the localhost.
* `displaynumber` is a sequence number (usually 0). It can be varied if there are multiple displays connected to one computer.
* `screennumber` is the screen number. A display can actually have multiple screens. Usually there's only one screen though where 0 is the default.

Setting the `DISPLAY` variable depends of your shell, but for the Bourne,
Bash or Korn shell, you could do the following to connect with the systems local display:

```bash
export DISPLAY=localhost:0.0
```

The remote server knows where it have to redirect the X network traffic
via the definition of the `DISPLAY` [environment variable][08]
which generally points to an X Display server located on your local computer.

## X Security

So you see, as the user, you have full control over where you wish to display the X client window.
So what prevents you from doing something malicious,
like popping up window on someone else terminal or read their key strokes?
After all, all you really need is their host name.
[X servers have three ways of authenticating connections][11] to it:
the host list mechanism (xhost) and the magic cookie mechanism (xauth).
Then there is ssh, that can forward X connections,
providing a protected connection between client and server over a network using a secure
[tunnelling protocol][12].

## The xhost Command
The [`xhost`][13] program is used to add and delete host (computer) names
or user names to the list of machines and users that are allowed
to make connections to the X server.
This provides a rudimentary form of privacy control and security.
A typical use is as follows:
Let's call the computer you are sitting at the "local host"
and the computer you want to connect to the "remote host".
You first use xhost to specify which computer you want to give
permission to connect to the X server of the local host.
Then you connect to the remote host using telnet. Next you set the
`DISPLAY` variable on the remote host.
You want to set this `DISPLAY` variable to the local host.
Now when you start up a program on the remote host,
its GUI will show up on the local host (not on the remote host).

For example, assume the IP address of the local host is 128.100.2.16
and the IP address of the remote host is 17.200.10.5.

On the local host, type the following at the command line:

```bash
xhost + 17.200.10.5
```

Log on to the remote host

```bash
telnet 17.200.10.5
```

On the remote host (through the telnet connection),
instruct the remote host to display windows on the local host by typing:

```bash
export DISPLAY=128.100.2.16:0.0
```

Now when you type `xterm` on the remote host,
you should see an `xterm`window on the local host.
You should remove the remote host from your access control list as follows.

```bash
xhost - 17.200.10.5
```

Some additional `xhost` commands:

* **`xhost`** - List all the hosts that have access to the X server
* **`xhost + hostname`** - Adds hostname to X server access control list.
* **`xhost - hostname`** - Removes hostname from X server access control list.
* **`xhost +`** - Turns off access control (all remote hosts will have access to X server ... generally a bad thing to do)
* **`xhost -`** - Turns access control back on (all remote hosts blocked access to X server)

`xhost` is a very insecure mechanism.
It does not distinguish between different users on the remote host.
Also, hostnames (addresses actually) can be [spoofed][14].
This is bad if you're on an untrusted network.

## The xauth Command
`xauth` allows access to anyone who knows the right secret.
Such a secret is called an authorization record, or a [magic cookie][15].
This authorization scheme is formally called `MIT-MAGIC-COOKIE-1`.
The cookies for different displays are stored together in the file `.Xauthority`
in the user's home directory
(you can specify a different cookie file with the `XAUTHORITY` environment variable).
The `xauth` application is a utility for accessing the `Xauthority` file.

On starting a session, the X server reads a cookie from the `Xauthority` file.
After that, the server only allows connections from clients that know the same cookie
(Note: When the cookie in `Xauthority` changes, the server will not pick up the change.).
If you want to use `xauth`, you must start the X server with the `auth authfile` argument.
You can generate a magic cookie for the `Xauthority` file using the utility [`mcookie`][16]
(typical usage: `xauth add :0 . \`mcookie\``).

Now that you have started your X session on the server and have your cookie in `Xauthority`,
you will have to transfer the cookie to the client host.
There are a few ways to do this.
The most basic way is to transfer the cookie manually by
listing the magic cookie for your display with `xauth list`
and injecting it into the remote hosts `Xauthority` via the `xauth` utility.

`xauth` has a clear security advantage over xhost.
You can limit access to specific users on specific computers
and it does not suffer from spoofed addresses as xhost does.
Never the less, [weaknesses have been found in `mcookie`][17].

## X Over SSH
Even with the `xhost` and `xauth` methods,
the  the X protocol is transmitted over the network with no encryption.
If you're  worried someone might snoop on your connections
(and you should worry), use `ssh`.
SSH, or the Secure Shell, allows secure ([encrypted][18] and [authenticated][19])
connections between any two devices running SSH.
These connections may include terminal sessions,
file transfers, TCP port forwarding, or X Window System forwarding.
SSH supports a wide variety of encryption algorithms.
It supports various [MAC algorithms][20], and it can use [public-key cryptography][21]
for authentication or the traditional username/password.

SSH can do something called "[X Forwarding][22]"
makes the communication secure by "[tunneling][23]"
the X protocol over the SSH secure link.
Forwarding is a type of interaction with another network application,
through a inter-mediator, in this case SSH.
SSH intercepts a service request from some other program on one side of an SSH connection,
sends it across the encrypted connection,
and delivers it to the intended recipient on the other side.
This process is mostly transparent to both sides of the connection:
each believes it is talking directly to its partner
and has no knowledge that forwarding is taking place.
This is called tunneling since X protocol is encapsulated within the a SSH protocol.

When setting up an SSH tunnel for X11,
the `xauth` key will automatically be copied to the remote system
(in a [munged][24] form to reduce the risk of forgery) and the `DISPLAY` variable will be set.

To turn on X forwarding over `ssh`,
use the command line switch `X` or write the following in your local `ssh` configuration file:

```bash
Host remote.host.name ForwardX11 yes
```

The current version of SSH supports the X11 SECURITY extension,
which provides two classes of clients:
trusted clients, which can do anything with the display, and untrusted clients,
which cannot inject synthetic events (mouse movement, keypresses)
or read data from other windows (e.g., take screenshots).
It should be possible to run almost all clients as untrusted,
leaving the trusted category for screencapture and screencast programs,
macro recorders, and other specialized utilities.

If you use `ssh -X remotemachine` the remote machine is treated as an untrusted client
and `ssh -Y remotemachine` the remote machine is treated as trusted client.
`-X` is supposedly the safe alternative to `-Y`.
However, as a Cygwin/X maintainer says "this is widely considered to be not useful,
because the Security extension uses an arbitrary and limited access control policy,
which results in a lot of applications not working correctly and what is really a false sense of security".

You can configuring SSH via the following files:

* per-user configuration is in `ssh/config`
* system-wide client configuration is in `etc/ssh/ssh_config`
* system-wide daemon configuration is in `etc/ssh/sshd_config`

The ssh server (`sshd`) at the remote end automatically sets `DISPLAY`
to point to its end of the X forwarding tunnel.
The remote tunnel end gets its own cookie;
the remote ssh server generates it for you and puts it in `~/.Xauthority` there.
So, X authorization with `ssh` is fully automatic.

X over SSH solves some of the problems inherent to classic X networking.
For example, SSH can tunnel X traffic through firewalls and NAT,
and the X configuration for the session is taken care of automatically.
It will also handle compression for low-bandwidth links.
Also, if you're using X11 forwarding,
you may want to consider setting `ForwardX11Trusted no` to guard against malicious clients.

## The Window Manager
The X design philosophy is much like the Linux/UNIX design philosophy, “tools, not policy”.
This philosophy extends to X not dictating what windows should look like on screen,
how to move them around with the mouse,
what keystrokes should be used to move between windows,
what the title bars on each window should look like, etc.
Instead, X delegates this responsibility to an application called a “Window Manager”.

There are many window managers available for X and each provides a different look and feel.
Some of them support  highly configurable virtual desktops like, [KDE][25] and [GNOME][26],
some of them are lightweight desktop like [LXDE][28] which comes with the RPi,
or you can operate bare bones (like I am on my PC while using the RPi)
and let MS Windows be your Window Manager via [Cygwin/X][29].

## X Display Manager
The X Display Manager (XDM) is an optional part of the X Window System
that is used for login session management.
XDM provides a graphical interface for choosing which display server to connect to,
and entering authorization information such as a login and password.
Like the Linux [getty][30] utility,
it performs system logins to the display being connected to
and then runs a session manager on behalf of the user (usually an X window manager).
XDM then waits for this program to exit,
signaling that the user is done and should be logged out of the display.
At this point, XDM can display the login and display chooser screens for the next user to login.

## X Nesting
You might want to run one X Window System desktop environment
on your local computer while accessing second computer,
including its own desktop environment,
all the while using the first computer’s screen and keyboard.
This sounds like multiple X Servers running.
One for the monitor and the other managing a graphics window as if it were a second monitor.
Fortunately, X Window System provides tools to do exactly this.
This has been done by designing a X Client to emulate an X Server
that then provides display services to other clients.
The open-source clients that do this are called `Xnest` and `Xephyr`.
And this display within a window concept is known as "X nesting".

`Xnest` is a Display Server implementing the X11 display server protocol that outputs to a window,
as apposed to a X display.
`Xnest` is a standard part of the XFree86 and X.org X Servers,
and provides an X Server that runs inside a standard X Window.
In other words, `Xnest` opens a window that works like another screen in which the user can open windows, etc.
At the X Protocol level, `Xnest` works like a X Client of the X Server hosting the window,
and as a X Server with respect to the X Window Manager
(i.e. applications that opens windows) within the `Xnest` session.
Therefore, `Xnest` can be used to run a virtual desktop of another computer
(which is running X Window) within a window.

For this discussion, you can think of [`Xephyr`][32] as an improved `Xnest`.
Also, the use of the `Xephyr` X Server instead of `Xnest` is generally recommended.
You can install `Xephyr` with the following.

```bash
sudo apt-get install xserver-xephyr
```

To open a `Xephyr` window with a specific size and suppress trace / error messaging,
do the following:

```bash
Xephyr -ac -screen 1280x1024 -br -reset -terminate 2> /dev/null :3 &
```

The options have the following purpose:

* **:3** is your display (displays are numbered starting with 0)
* **-ac** disable access control restrictions (allow you to forward X)
* **-screen 1280x1024** sets the window size
* **-br** set the background to black
* **-reset** reset after last client exists
* **-terminate** terminate `Xephyr` at server reset (does not always work)
* **2> /dev/null** redirects trace and error messages

To add a `xterm` into another account and the GNOME Window Manager, you could do the following:

```bash
Xephyr -ac -screen 1280x1024 -br -reset -terminate 2> /dev/null :3 &
DISPLAY=:3.0 gnome-wm &
DISPLAY=:3.0 ssh -X jennie@desktop xterm
```

Or you could start a GNOME Desktop session, and this will being with it its display manager

```bash
Xephyr -ac -screen 1280x1024 -br -reset -terminate 2> /dev/null :3 &
DISPLAY=:3 gnome-session &
DISPLAY=:3.0 ssh -XfC jennie@desktop xterm
```

This doesn't give you the full desktop environment.
The best way to do this is to go thought the X Display Manager (aka GUI Login Manager).
This is shown below in the next section.

`Xephyr` can also be used to [remotely login to a desktop session][34].
When remotely starting a X Window System desktop,
[XDMCP (X Display Manager Control Protocol)][33] is typically used to establish
the connection between the remote X Display Manager (XDM) daemon
and the local X Server.
Once the connection has been established, and the user has successfully authenticated,
the XDM daemon launches the X client session, which is displayed on the user's workstation.

XDMCP suffers from some of the same security problem as all the X Protocols,
but unfortunately, cannot be tunnelled over SSH due to it's use of UDP.
Attempts to use XDMCP to connect to a remote system
via SSH will fail and an error message will be displayed.

For security reasons,
XDMCP is not enabled by default on most modern UNIX distributions.
You will have to enable remote logins to your X Display Manager.
To enable XDMCP on my LXDE based system,
I configuring the file `/etc/lightdm/lightdm.conf` so it contains

```
[SeatDefaults]
user-session=ubuntu
autologin-user=false
xserver-allow-tcp=true
greeter-session=unity-greeter

[XDMCPServer]
enabled=true
port=177
#key=
```

The key enabler here is the term `enabled=true`
(this is generally set to `false` for security purposes).

Now get out of X Window and restart the lightdm with `sudo restart lightdm`
(make sure to exit any running applications first)
or reboot your system so the changes take effect.
To log into into my Linux system (aka `desktop`),
from the same system as if they are remote to each other,
I used the following command works well.

```bash
Xephyr :3 -ac -screen 1280x1024 -br -reset -terminate -query desktop 2> /dev/null &
```

The new option **`-query desktop`** cause `Xephyr` to contact the host computer `desktop` via XDMCP.

# Keyboard and Mouse
* [Set up key mappings with .Xmodmap](https://blacketernal.wordpress.com/set-up-key-mappings-with-xmodmap/)
* [Linux: xmodmap Tutorial](http://xahlee.info/linux/linux_xmodmap_tutorial.html)
* [Using XBindKeys on Ubuntu Linux to Remap Key Commands](http://butlerpc.net/blog/2011/01/using-xbindkeys-on-ubuntu-linux-to-remap-key-commands/)

================================================================================

Dot X Files
==========
What is the purpose of all those X Window System files
`.xinitrc`, `.xsession`, `.xsessionrc`, `.Xresources`, and `.Xdefaults`?
And what is the differance between the intialization tools `xinit` and `startx`?

The `xinit` program is used to start the X server and clients on systems that don't have,
or use, a display login manager like GDM/KDM/XDM.
When `xinit` is run without specific client options it looks for a file called `.xinitrc`
in the user's home directory and runs it as a shell script.
This configuration file/script is used to start up client programs.

The `startx` script also starts `xinit` but also initializes `xauth`.
In general, `xinit` and `startx` start a [display server][10] and run an arbitrary script.
Typically, this script runs a number of programs and a window manager.

Background
----------
A [window manager][05] is just one more application for X11, like netscape or gimp or xterm.
Many people new to X11 come to believe that X11 runs the window manager and the
window manager runs programs. But that's not true. If configured right, you can
run all your applications under X11, kill the window manager, and start another window manager up.

Starting an X session is typically done in one of two ways:

1. The X session is started via a display manager (like [LightDM][01] in Ubuntu Unity),
and the user logs in at a GUI screen.
2. The user starts X manually after logging in to a text console. The latter is
typically done with the [startx][02] command, which is a simple shell script
wrapper for [xinit][03].  If no client program is specified on the command line,
xinit will look for a [.xinitrc][04] file in the user's home directory, to run as a
shell script. If found, this then would in turn run whatever user specified
commands to set up the environment, or launch programs that the file contained.
If .xinitrc isn't present, then global xinitrc file (/etc/X11/xinit/xinitrc) will be used.

The .xsessionrc and .xinitrc files are used to set up a suitable X environment,
and to launch other programs, a.k.a "clients", that we may want available as
soon as X is started. You likely have a system wide xsessionrc and xinitrc to
start a predefined set off programs. To customize this, create your own in your
home directory. Name it .i.xsessionrc or xinitrc, make sure it is an executable
script, and chmod +x.

CustomXSession - <https://wiki.ubuntu.com/CustomXSession>

To debug your issues you should have a look in `~/.xsession-errors`

`xsessionrc` is sourced by 40x11-common_xsessionrc during the start of the X session. It is intended for setting session-wide environment variables that should apply to all apps, such as locale information.

If `.xinitrc` isn't present, then global xinitrc file `/etc/X11/xinit/xinitrc` will be used.
To debug your issues you should have a look in `~/.xsession-errors`

## .Xresources or .Xdefaults?
Many X programs have user-level configuration options that can be set in the [X server resource database][06].
Depending on your version of X.Org,
the most common ways to achieve persistent configuration for your X programs are to store them in either
the `.Xresources` or `.Xdefaults` files which are read when X starts or when the X client starts, respectively.
Both are user configurable dotfiles located in `$HOME` used to set X resources.
These are configuration parameters for X client applications, such as:

* defining terminal colors
* configuring terminal preferences
* setting dots-per-inch (DPI), anti-aliasing, hinting and other X font settings
* changing the Xcursor theme
* theming xscreensaver
* altering preferences on low-level X applications (e.g. xclock, xeyes)

Consider the X program `xterm`.
You want to make the background black and the foreground white.
This can be achieved by passing some command line arguments to xterm:

```bash
# xterm with background black and foreground white
xterm -bg black -fg white
```

This is fine if you want this for only one time,
but if you want it to be the default, you put it in a configuration file
`.Xresources` or `.Xdefaults` as follows:

```bash
XTerm*background: black
XTerm*foreground: white
```

The difference between these two files are the following:

* `.Xdefaults` is the older method of storing X resources.
This file is re-read every time an Xlib program is started.
If X11 is used over the network, the file must be present on the same filesystem as the programs.
* `.Xresources` is newer. It is loaded with [`xrdb`][09] into the [resource manager][07]
property of the X11 root window.
Whenever any program looks up a resource, it is read straight from resource manager.

If `.Xresources` does not exist,
Xlib falls back to the old method of reading `.Xdefaults` on every program startup.
Note that most distributions will load `.Xresources` automatically if it is present,
causing `.Xdefaults` to be ignored even if you have never run `xrdb` manually.

The advantage of the new method is that it's enough to call `xrdb` once,
and the resources will be available to any program running on this display,
whether local or remote.
Use of `.Xdefaults` comes at the cost that basically
all X programs needs to parse this file every time you run one.
A better way is to put the configuration options in `.Xresources`
and store the configuration in the X server’s resource database by using the `xrdb` command:

```bash
# intialize user configurable resources using the X server resource database utility, xrdb
xrdb -merge $HOME/.Xresources
```

This execution of `xrdb` is done automatically when you login on most Linux distributions.
Also, the name `.Xresources` is only a convention –
you can use `xrdb` to load any file, even `.Xdefaults`.

To Do
-----
* [Running X](http://www.tldp.org/HOWTO/XWindow-User-HOWTO/runningx.html)
* [The X Window User HOWTO](http://www.tldp.org/HOWTO/XWindow-User-HOWTO/)
* [example of a more complex .xinitrc file you can learn from](http://git.sysphere.org/dotfiles/tree/xinitrc)

Referances for .Xresources
--------------------------
* [Xterm Manual Page](http://www.x.org/archive/X11R6.8.1/doc/xterm.1.html)
* [Using the .Xdefaults file](https://engineering.purdue.edu/ECN/Support/KB/Docs/UsingTheXdefaultsFil)
* [Using Configuration Files to Customize Your Windows Environment](http://h30097.www3.hp.com/docs/base_doc/DOCUMENTATION/V40F_HTML/AQ917BTE/DOCU_012.HTM)
* [Post your .Xdefaults and terminal apps color schemes with screenshot](http://crunchbang.org/forums/viewtopic.php?id=9935)
* [256-Color XTerms in Ubuntu](http://push.cx/2008/256-color-xterms-in-ubuntu)



[01]:https://wiki.ubuntu.com/LightDM
[02]:http://linux.die.net/man/1/startx
[03]:http://www.x.org/archive/X11R6.8.1/doc/xinit.1.html
[04]:http://www.slackbook.org/html/x-window-system-xinitrc.html
[05]:http://en.wikipedia.org/wiki/X_window_manager
[06]:https://en.wikipedia.org/wiki/X_resources
[07]:https://tronche.com/gui/x/xlib/resource-manager/
[08]:http://gerardnico.com/wiki/linux/environment_variable
[09]:http://docstore.mik.ua/orelly/unix3/upt/ch06_08.htm
[10]:https://en.wikipedia.org/wiki/Display_server
[11]:http://www.linux-tutorial.info/modules.php?name=Howto&amp;pagename=Remote-X-Apps/Remote-X-Apps-6.html
[12]:http://en.wikipedia.org/wiki/Tunnelling_protocol
[13]:http://www.xfree86.org/current/xhost.1.html
[14]:http://en.wikipedia.org/wiki/Spoofing_attack
[15]:http://en.wikipedia.org/wiki/Magic_cookie
[16]:http://linux.die.net/man/1/mcookie
[17]:https://tools.cisco.com/security/center/viewAlert.x?alertId=5448
[18]:http://en.wikipedia.org/wiki/Encryption"
[19]:http://en.wikipedia.org/wiki/Authentication
[20]:http://en.wikipedia.org/wiki/Message_authentication_code
[21]:http://en.wikipedia.org/wiki/Public-key_cryptography
[22]:http://docstore.mik.ua/orelly/networking_2ndEd/ssh/ch09_01.htm#ch09-31407
[23]:http://en.wikipedia.org/wiki/Tunneling_protocol
[24]:https://en.wikipedia.org/wiki/Mung_(computer_term)
[25]:http://www.kde.org/
[26]:http://www.gnome.org/
[27]:http://en.wikipedia.org/wiki/X_display_manager_(program_type)
[28]:http://lxde.org/
[29]:http://x.cygwin.com/
[30]:http://en.wikipedia.org/wiki/Getty_(Unix)
[31]:http://blog.worldlabel.com/2009/turn-your-old-laptop-into-a-powerful-linux-workhorse.html
[32]:http://nims11.wordpress.com/2012/06/24/nested-x-servers-with-xephyr/
[33]:http://www.x.org/releases/X11R7.7/doc/libXdmcp/xdmcp.html
[34]:http://techpad.co.uk/content.php?sid=72
[35]:https://help.ubuntu.com/community/FreeNX
[36]:
[37]:http://wiki.lxde.org/en/LXSession
[38]:http://en.wikipedia.org/wiki/X11
[39]:http://xfree86.sourceforge.net/
[40]:http://www.x.org/wiki/
[41]:http://x.cygwin.com/
[42]:http://en.wikipedia.org/wiki/X_Window_System_protocols_and_architecture
[43]:http://en.wikipedia.org/wiki/Desktop_environment
[44]:http://askubuntu.com/questions/150487/what-happens-under-the-covers-to-log-me-in-and-start-up-the-unity-graphics-user?r
[45]:
[46]:
[47]:
[48]:
[49]:http://www.x.org/wiki/
[50]:http://openbox.org/
[51]:http://wiki.lxde.org/en/LXDM
[52]:http://www.x.org/releases/X11R7.7/doc/libXdmcp/xdmcp.html
[53]:http://www.tldp.org/HOWTO/XWindow-User-HOWTO/runningx.html
[54]:
[55]:
[56]:http://en.wikipedia.org/wiki/Window_Maker
[57]:http://en.wikipedia.org/wiki/Sawfish_(window_manager)
[58]:http://en.wikipedia.org/wiki/FVWM
[59]:http://www.straightrunning.com/XmingNotes/
[60]:http://www.x.org/wiki/XServer/
[61]:http://lxde.org/
[62]:http://www.xfce.org/
[63]:http://www.kde.org/
[64]:http://www.gnome.org/
[65]:https://unity.ubuntu.com/about/
[66]:http://www.xfree86.org/current/startx.1.html
[67]:http://www.x.org/archive/X11R6.8.1/doc/xinit.1.html
[68]:http://www.freedesktop.org/wiki/Software/LightDM/
[69]:
[70]:

