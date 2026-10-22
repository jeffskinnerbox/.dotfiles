
----
1st Prompt ...

# This is My Dotfiles Directory
This directory structure contains nearly all the configuration set-up files
I need for establishing my development environment on this system
and can be used to setup a similar user environment across other systems I'm using.

I want to convert this directory system so that if fully supports the management strategy below.

## Management Strategy
[Dotfiles][01] helps you to personalize your environment across all your machine for a unified experience.
It will be hosted as a GitHub repository to help restore/configure new machine via script based on the OS you run.
All the configuration will be managed using [GNU Stow][04].

GNU Stow is a symlink manager which takes distinct packages of software
and/or data located in separate directories on the filesystem,
and makes them appear to be installed in the same place.
For example, `/usr/local/bin` could contain symlinks to files
within `/usr/local/stow/emacs/bin`, `/usr/local/stow/perl/bin` etc.,
and likewise recursively for any other subdirectories such as .../share, .../man, and so on.

Within this objective a unified experience across many machines,
you must also assure the OS and its tools / libraries are also properly established.
For this, I want to use [Ansible][09].
Ansible is an open-source IT automation tool that manages servers,
deploys applications, and configures systems.
It uses simple, human-readable YAML scripts called playbooks to automate repetitive tasks
across multiple computers without needing software agents installed on the target machines.

An important part of any system configuration is the use and protection of secrets like passwords and keys.
For this, I want to use [Bitwarden][10].
Bitwarden is an open-source, zero-knowledge encrypted platform used to
store, manage, and share sensitive data like passwords, API keys, and SSH keys.
You can integrate it with Ansible using the Bitwarden Secrets Manager lookup plugin
or the `community.general.bitwarden` plugin to pull secrets into playbooks dynamically without hardcoding them.

### Target Use Cases
A use case is a step-by-step description of how a user (called an "actor")
interacts with a system (such as a website, app, or software) to achieve a specific goal.

Some definitions for use cases below:
* system - computer or docker container I am creating or maintaining (e.g. `desktop`, `macbook-pro`, `NucBoxM6`, `NucBoxG5`, etc.)
* tool - one or more programs or scripts installed on a system used by the system administrator or provided to all the system users.
* health-check - validation of proper installation and operation of a tool
* life-cycle - installation, update, health-check, removal of a tool

1. Use this `.dotfiles` directory to maintain `desktop` configuration
    * **Actor**: system administrator
    * **System**: `desktop`
    * **Objective**: Install a new tool that requires a configuration file
    * **Basic Flow**:
        1. Check if the tool is within `.dotfiles`, and if it is,
           create an Ansible script that maintains the whole life-cycle of the tool and store it with the tools current location.
           Ansible script should be written so it can be used on any system, not only this system.
           Do not execute the Ansible script, you are done.
        1. Check if the tool is within `.dotfiles`, and if not,
           create an Ansible script that maintains the whole life-cycle of the tool and store it with the tools current location.
           Execute the Ansible script and install the tool on this system.
        1. Place default configuration file within `.dotfiles` structure
        1. Actor (not Claude) creates the symlink within `~/.config` or other directory
    * **Alternative Flow**:
        1. There are no alternative flows.
1. FUTURE USE CASE - Setup environment on new hardware
1. FUTURE USE CASE - Setup environment on new docker container
1. FUTURE USE CASE - update environment on existing systems docker container
1. FUTURE USE CASE - update environment on existing systems (`desktop`, `macbook-pro`, `NucBoxM6`, `NucBoxG5`)

## My Environments
Listed below are my current computer environments I use for development, testing, and production.
This will almost certainly be expanded over time.

### Computer Systems
These are the computing environments that I want my `.dotfiles` directory to reside
and where it would be used to manage the configuration.
1. My main computing environment, where most of my work is performed
  and where this `.dotfile` directory is maintained (aka single source of truth):
    * named `desktop` with [Ubuntu 26.04.1 LTS][03] OS on [Micro-Star International Co. MS-7D25][02] motherboard,
      [x86-64][05] architecture, with 32G DDR5 RAM
1. My portable computing environment, which I use when traveling or working external to my home:
    * named `macbook-pro` with macOS Sequois 15.7.9 on MacBook Pro 2.2GHz 6-core Intel Core i7,
      with 16 GB 2400 MHz DDR4
1. My ROS 2 production environment, used in robotics development as a ROS 2 off-robot compute resources:
    * name `NucBoxM6` with [Ubuntu 24.04.2 LTS][03] OS, [GMKtec NucBox M6, AMD R5 6600H (6C/12T up to 4.50 GHz) processor][06],
      [x86-64][05] architecture, with 32G DDR5 RAM
1. My Windows 11 environment, used only when I must use a Microsoft Windows application
   or when I use [Windows Subsystem for Linux (WSL)][11]:
    * named `NucBoxG5` with [Microsoft Windows 11][07] OS, [GMKtec NucBox G5][08], [x86-64][05] architecture, with 12G DDR5 RAM
1. [Raspberry 5][12] TBD

### Embedded Systems
I frequently develop hardware systems with [Raspberry Pi Pico family][13]
and the [ESP32 family][14] microcontrollers,
typically using C++ and [CircuitPython][15] software.
This work requires special software tools and libraries
and typically done on the `desktop` and `macbook-pro` systems.

## Supporting Tools
### Stow
Stow's job is to make the config files in your repo appear where your tools expect them, as symlinks.
Each tool reads its config from your repo, and your edits land in git right away.
Stow only creates and removes links.
It doesn't install anything, hold secrets or know which machine it's on.

#### One-sentence rule
If it's a shared config file you edit by hand, it lives in a pkg-* folder and Stow links it.
Anything installed, system-level, machine-specific or secret belongs to Ansible.

#### Stow owns
1. Linking shared config: one pkg-<tool>/ folder per tool, mirroring where its files go under $HOME or ~/.config.
2. Removing links: stow --delete takes a package's links away cleanly.
3. Re-linking: stow --restow repairs links after a package's files change (for example, a file was added or renamed).
4. Leaving out files that don't belong in your home: .stow-local-ignore keeps READMEs, docs, bin/ and similar files
   from being linked.
5. The include hooks: each stowed file has one line that loads an optional local file (.bashrc.local,
   .gitconfig.local, ~/.ssh/config.d/*, etc.). The hook lives in the repo; the local file doesn't.

#### Stow does NOT own
* Installing tools. Ansible installs bash, tmux, nvim, etc. before Stow runs.
* Deciding which packages a machine gets. Ansible picks the package list per profile and calls Stow with it.
* Secrets and per-machine values. Ansible writes those to untracked *.local and secrets files.
* Backing up conflicting files. Ansible moves stock files like ~/.bashrc aside first. Stow just refuses to overwrite.
* Plugins. Plugin managers (lazy.nvim, tpm) download them after stowing. Git submodules are replaced.
* Checking links stay intact. An Ansible check task finds links that apps replaced with regular files.

#### What goes in a pkg-* folder
  ┌────────────────────────────────────────────────────────────┬──────────────────────────────────────────────────┐
  │                    Belongs in a package                    │                    Stays out                     │
  ├────────────────────────────────────────────────────────────┼──────────────────────────────────────────────────┤
  │ Config you edit by hand and want the same on every machine │ Secrets                                          │
  ├────────────────────────────────────────────────────────────┼──────────────────────────────────────────────────┤
  │ The include hooks for local overrides                      │ Hostname or OS checks (if hostname ==)           │
  ├────────────────────────────────────────────────────────────┼──────────────────────────────────────────────────┤
  │ Small helper scripts the config calls                      │ Files apps generate (caches, history, autosaves) │
  ├────────────────────────────────────────────────────────────┼──────────────────────────────────────────────────┤
  │                                                            │ Docs, READMEs (or listed in .stow-local-ignore)  │
  └────────────────────────────────────────────────────────────┴──────────────────────────────────────────────────┘

#### When you run it
* New machine: Ansible runs it as part of the playbook.
* Added a new package folder: stow pkg-<name>, or re-run the playbook.
* Edited a config file: nothing to run. The link already points at the repo.
* A link broke: stow --restow pkg-<name>.

### Ansible
Ansible's job is to turn a bare OS into a machine that's ready for your dotfiles, and then put them in place.
It manages the machine. Stow manages your config files, and Bitwarden holds your secrets.
Ansible is the conductor that runs everything else in the right order.

#### One-sentence rule
If it's installed, configured at the system level, depends on the machine, or is secret, Ansible handles it.
If it's a shared config file you edit by hand, Stow handles it.

#### Ansible owns
  1. System packages: apt or brew packages, PPAs and third-party repos.
  2. Tools outside the package manager, at pinned versions: neovim, pyenv, nvm, rustup, nerd fonts, zellij, etc.
  3. System settings: login shell, user groups, systemd services, ROS on the NucBox.
  4. Machine profiles: which machine gets what (desktop / server / mac / ros) through inventory and vars.
  5. Secrets delivery: reads Bitwarden once and writes 0600 files (~/.config/secrets/env, etc.).
  6. Per-machine files: writes only *.local include files (.bashrc.local, .gitconfig.local, ...).
  7. Running Stow:
     * backs up conflicting files
     * runs stow for the profile's package list
     * checks for links that broke
  8. Installing editor and shell plugins: lazy.nvim restore and the tpm install, after stowing.
  9. SSH keys: generates them per machine and registers them with GitHub.

#### Ansible does NOT own
* Dotfile contents. These live in pkg-*, are linked by Stow, and are edited directly.
* Secret values. They live in Bitwarden. Ansible only passes them through and never commits them.
* Its own startup. Installing git, Ansible and bw and unlocking Bitwarden is bootstrap.sh's job.
* Interactive logins. 2FA, gh auth login and app sign-ins stay on a manual checklist.
* Day-to-day config tweaks. You edit the files directly; there's no need to re-run Ansible.

#### Responsibilities at a glance
  ┌───────────────────────────────────────────────┬──────────────┬─────────────────────────────────────┐
  │                     Layer                     │     Tool     │          Changes how often          │
  ├───────────────────────────────────────────────┼──────────────┼─────────────────────────────────────┤
  │ Startup (git, ansible, bw)                    │ bootstrap.sh │ Once per machine                    │
  ├───────────────────────────────────────────────┼──────────────┼─────────────────────────────────────┤
  │ Machine (packages, tools, services, profiles) │ Ansible      │ When adding a tool or a new machine │
  ├───────────────────────────────────────────────┼──────────────┼─────────────────────────────────────┤
  │ Secrets (values)                              │ Bitwarden    │ When rotating                       │
  ├───────────────────────────────────────────────┼──────────────┼─────────────────────────────────────┤
  │ Secrets and per-machine files on disk         │ Ansible      │ On re-run with --tags secrets       │
  ├───────────────────────────────────────────────┼──────────────┼─────────────────────────────────────┤
  │ Config (dotfiles)                             │ Stow + git   │ Daily                               │
  └───────────────────────────────────────────────┴──────────────┴─────────────────────────────────────┘

#### When you run it
* New machine: a full run.
* Added a tool or package: re-run the playbook, or just that tool's role via --tags.
* Rotated a secret: --tags secrets.
* Monthly or in CI: a full run that should report changed=0. Anything else means drift or upstream breakage.

### Bitwarden
Bitwarden's job is to be the one place your secret values live. It stores them encrypted and hands them to Ansible
during a playbook run. It never touches your dotfiles, and nothing in the repo contains a secret, not even an
encrypted one.

#### One-sentence rule
If it's a value that would cause damage if someone saw it, it lives only in Bitwarden.
Ansible delivers it to the machine, and Stowed config only points at the file it lands in.

#### Bitwarden owns
  1. Secret values: API keys (e.g. ANTHROPIC_API_KEY), tokens (GITHUB_TOKEN), any passwords your config needs.
  2. One "dotfiles" item: a secure note named something like dotfiles/secrets, with one custom field per secret. Ansible
     reads it in a single lookup, which keeps runs fast and avoids ambiguous names.
  3. Per-machine items (if needed): dotfiles/host/<hostname> for secrets that differ by machine.
  4. Long-lived keys you can't regenerate: a GPG signing key, if you keep using GPG.
  5. Rotation: you change a value in Bitwarden. It's the only place you edit a secret.

#### Bitwarden does NOT own
* Putting secrets on disk. Ansible reads them and writes the 0600 files (~/.config/secrets/env, *.local).
* SSH keys. Ansible generates a new key per machine and registers it with GitHub. No private key is copied between
    machines.
* Config files. Those are Stow's, and they only source the secrets file.
* CI secrets. CI uses test values. Your master password never goes into a CI system.
* Getting itself installed and unlocked. bootstrap.sh installs bw, logs in with your API key and runs bw unlock. You
    type the master password once per run.

#### How a secret flows
  Bitwarden item ──(bw unlock → BW_SESSION)──► Ansible lookup (once, no_log)
                                                │
                                                ▼
                            ~/.config/secrets/env (0600, untracked)
                                                │
                            ~/.bashrc (stowed) ──sources──┘

#### When you use it
* New machine: the bootstrap unlocks it once, then the playbook reads everything.
* New secret: add a field to dotfiles/secrets, add its name to Ansible's secrets_env list, run --tags secrets.
* Rotated secret: change it in Bitwarden, then run --tags secrets on each machine.
  Machines that aren't re-run keep the old value.
* Lost or retired machine: rotate every secret it held, and remove its SSH key from GitHub.

#### Rules to keep it safe
* Every Ansible task that touches secret values has no_log: true.
* BW_SESSION exists only in the bootstrap shell. Never put it in .bashrc.
* Run bw sync at the start of each playbook so values aren't stale.
* A gitleaks pre-commit hook blocks any secret that slips into the repo.



[01]:https://github.com/rvbug/.dotfiles
[02]:https://www.msi.com/Motherboard/PRO-Z690-A-DDR4
[03]:https://releases.ubuntu.com
[04]:https://www.gnu.org/software/stow/
[05]:https://en.wikipedia.org/wiki/X86-64
[06]:https://www.gmktec.com/products/amd-ryzen-5-6600h-mini-pc-nucbox-m6
[07]:https://www.microsoft.com/en-us/windows/
[08]:https://de.gmktec.com/en/products/gmktec-nucbox-g5-intel-alder-lake-n97-mini-pc
[09]:https://docs.ansible.com/
[10]:https://bitwarden.com/
[11]:https://learn.microsoft.com/en-us/windows/wsl/
[12]:https://www.raspberrypi.com/products/raspberry-pi-5/
[13]:https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html
[14]:https://www.digikey.com/en/maker/blogs/2024/a-guide-for-the-esp32-microcontroller-series
[15]:https://circuitpython.org/


----

NOT PART OF THIS DOCUMENT:
    Resume this session with:
    claude --resume ca235874-2687-40e6-9039-db9697129a40
    jeff@desktop: ~/.dotfiles (main) $




