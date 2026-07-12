[Dotfiles][01] helps you to personalize your environment across all your machine for a unified experience.
It will be hosted as a GitHub repository to help restore/configure new machine via script based on the OS you run.
All the configuration will be managed using [GNU Stow][04].

* [~/.dotfiles in 100 Seconds](https://www.youtube.com/watch?v=r_MpUP6aKiQ)
* [~/.dotfiles 101: A Zero to Configuration Hero Blueprint](https://www.youtube.com/watch?v=WpQ5YiM7rD4)
* [How To ACTUALLY Manage Dotfiles with Stow | Full Guide + Git Workflow](https://www.youtube.com/watch?v=TLFsee7DDSI)

I want Claude Code to help create a management strategy, with supporting tools.

## My Environment
These are the computing environments that I want my `.dotfiles` directory to reside and where it would be used to manage the configuration.
* My main computing environment, where most of my work is performed (and where this `.dotfile` directory is maintained):
  named `desktop` with [Ubuntu 24.04.4 LTS][03] OS on [Micro-Star International Co. MS-7D25][02] motherboard, [x86-64][05] architecture, with 32G DDR5 RAM
* My portable environment, which I use when traveling or external to my home:
  named xxx with xxx OS on MacBook Pro **CPU**
* My ROS 2 development environment, used for robotics development:
  name `NucBoxM6` with [Ubuntu 24.04.2 LTS][03] OS, [GMKtec NucBox M6, AMD R5 6600H (6C/12T up to 4.50 GHz) processor][06],
  [x86-64][05] architecture, with 32G DDR5 RAM
* My Windows 11 environment, used only when I must use a Microsoft Windows application:
  [Microsoft Windows 11][07] OS, [GMKtec NucBox G5][08], [x86-64][05] architecture, with 12G DDR5 RAM

## Management Strategy
This directory structure contains nearly all the configuration / set-up files I need for establishing
my development environment across multiple systems I'm using

## Supporting Tools



[01]:https://github.com/rvbug/.dotfiles
[02]:https://www.msi.com/Motherboard/PRO-Z690-A-DDR4
[03]:https://releases.ubuntu.com/noble/
[04]:https://www.gnu.org/software/stow/
[05]:https://en.wikipedia.org/wiki/X86-64
[06]:https://www.gmktec.com/products/amd-ryzen-5-6600h-mini-pc-nucbox-m6
[07]:https://www.microsoft.com/en-us/windows/
[08]:https://de.gmktec.com/en/products/gmktec-nucbox-g5-intel-alder-lake-n97-mini-pc


