<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

In my `vi` / `vim` / `nvim` journey,
I have may VERY heavy reuse of other peoples work.
[David Winterbottom][01] very descriptively called what I was doing "cargo-culting other people’s `~/.vim` folders"
(see [cargo cult][02], [cargo cult programming][03]).

Remember, error messages are your friend!
The first and more important thing,
without knowing your configuration and error messages, it becomes very difficult to debug NeoVim troubles.

Sources:

* [Debugging Vim by example][01]
* [NeoVim](https://neovim.io/)
* [NeoVim Documentation](https://neovim.io/doc/)

#### Most Troubles Are In Your Configuration

You may wnat to start your debugging without any configuration,
so you may want to start `nvim` without any customization from you or others:

```bash
# start neovim with no config at all
 nvim -u NONE -U NONE -N
```

If your error does not appear,
you know you have a problem in your configuration.

#### Process of Elimination

You can try and locate the source of a problem by first stripping away all
custom plugins & configuration and then systematically add them back in.
Commenting out / disabling some settings/plugins until you find the culprit.
I use `lazy.nvim` to manage my plugins and have made a habit of incuding the variable `enabled`
when I load a plugin.
Within a plugin, I can set `enable = false` to help isolate troubles.

#### Make NVim More Verbose

eThe next step might be to use “verbose mode” to find out what `nvim` is doing.
You can start `nvim` in verbose mode with:

```bash
# create a more verbose trace messages (10 is the highest level)
nvim -V2 <your-file>
```

#### Isolate Where Thing Are Going Wrong

First, you might want to sprinkle in a few print statements:

```lua
-- debug posted to ':messages'
print("DEBUG: Executing nvim-lint event ...")
```

#### Review NeoVim's Log Files

Nvim's data logs are located in (typically) `$HOME/.local/share/nvim/*.log`
and and includes the directories `swap/` for open files,
the `shada/` (Shared Data) files,
`undo/` to support the undo function in `nvim`
and `lazy/` to support the Lazy plugin.

Given my configuration for `nvim`, the log files can be found in
`$HOME/.local/state/nvim/lua/active/` for `vi`
or `$HOME/.local/state/nvim/lua/experimental/` for vi-dev.
Typical example of logs are:

```bash
# goto log files directoru for vi-dev (experimental)
cd $HOME/.local/state/nvim/lua/experimental

# list log files
$ ls *log
conform.log  log  lsp.log  luasnip.log  mason.log  noice.log
```

#### Option Values is Wrong

You can check an option’s value to see what and where it is being set:

```nvim
-- what is the value
:set textwidth?

-- what file has last set the option
:verbose set textwidth?
```

To investigate, I looked up which Vim file had last set the option by prepending :verbose:

```nvim
-- which file had last set the option
:verbose set textwidth?
```

#### NeoVim Has Slow Start-up

If you notice `nvim` takes a noticeably long time to start-up,
consider this:

```bash
# move to someplace to dump files
cd ~/tmp

# start nvim in profiling mode WITHOUT your configuration
vi-dev +q -u NONE -U NONE -N --startuptime startup-no-config.txt

# start nvim in profiling mode WITH your configuration
vi-dev +q --startuptime startup.txt
```

---------------

# Setup Test Environment

* [NeoVim Testing](http://neovimcraft.com/?search=tag%3Atest)

## VirtualBox

[VirtualBox][30] is a [full virtualization][31] x86 / AMD64 / Intel64 hardware architecture
(contrast this with [hardware-assisted virtualization][32]).
It creates a [virtual machine (VM)][33], aka an emulation of a computer system.
Virtual machines (VM) behave like a separate computer system,
complete with virtual hardware devices.
The VM runs as a process in a window on your current operating system.
You can boot an operating system installer disc (or live CD) inside the virtual machine,
and the operating system will be “tricked” into thinking it’s running on a real computer.
It will install and run just as it would on a real, physical machine.

## VBoxManage

[VBoxManage][34] is the command-line interface to Oracle VM VirtualBox.
With it, you can completely control Oracle VM VirtualBox from the command line of your host operating system.
It exposes all the features of the virtualization engine,
even those that cannot be accessed from the GUI.

## Vagrant

[Vagrant][35] is a tool that offers a simple and easy to use
command-line client for managing virtual environments.
It effective provides a single common management UI for many of the popular virtualization platforms, including VirtualBox.
I started using it because it made it easier for me to
standup new software solutions for testing without disrupting my working system.

Vagrant is a tool for building and managing virtual machine environments in a single workflow.
Vagrant has an easy-to-use workflow, makes automation easy, and lowers development environment setup time.
Machines are provisioned on top of VirtualBox, VMware, AWS, or any other provider.
Then, industry-standard provisioning tools such as
shell scripts, Chef, or Puppet, can automatically install
and configure software on the virtual machine.

**For developers**, Vagrant will isolate dependencies and their configuration within a
single disposable, consistent environment, without sacrificing
any of the tools you are used to working with (editors, browsers, debuggers, etc.).
Once you or someone else creates a single [Vagrantfile][36],
you just need to `vagrant up` and everything is installed and configured for you to work.

**For DevOps**, Vagrant gives you a disposable environment
and consistent workflow for developing and testing infrastructure management scripts.
You can quickly test things like shell scripts, Chef cookbooks, Puppet modules,
and more using local virtualization such as VirtualBox or VMware.
Then, with the same configuration, you can test these scripts
on remote clouds such as AWS or RackSpace with the same workflow.

So the high level difference between these two is VirtualBox is the creator of virtual machines
and Vagrant is a manager of the virtual machines environment.
Also, Vagrant and Docker suport different types of virtualisation.
Vagrant is related to virtual machines and Docker is a virtual environment tool.

Aside from reading [Vagrant's official documentation][37],
it also helps to know some of the basic terminology used by Vagrant:

* **Vagrant Box:**
A box is basically a package containing a representation of a virtual machine running a specific operating system.
To be more simple, it is a base image of any Operating System or Kernel. It may be for a specific Provider.
* **Providers:**
The Provider is the piece of software responsible for creating and managing the virtual machines used by Vagrant.
The main providers are Virtualbox and VMware, but the default one is VirtualBox, since it's free and open source.
* **Provisioners:**
Provisioner will do some task(s) using the vm instance already provided.
The provisioners are used to set up the virtual server, installing all necessary software and executing different tasks. The most used provisioners are: Puppet, Chef and Ansible.
Shell Script is also a very common option. You can find more information about vagrant provisioners here.
* **The Vagrantfile:**
The basic vagrant configuration is based in one file, the Vagrantfile. It shall be placed in your repository root.
In this file you will define which base box you want - a box is, basically,
a package with an operational system to be run in your virtual machine.

## Ansible

You may have heard of using configuration management tools
like [Chef][38], [Puppet][39], [SaltStack][40], [Terraform][41], [CFEngine][42]
or simply using Bash scripts to provision servers or Vagrant Boxes.
The major difference between other configuration management tools and Anisble,
is that underneath Ansible is just SSH.
Chef and Puppet both have dependencies that must be installed
on the server before you can use them, Ansible does not.
[Ansible is agentless][43] — meaning there are no daemons or agents needed to run a particular action.
It runs on a machine apart from from your VMs
and uses SSH to connect to the servers and run the required commands.
Hence it is a push model, meaning no additional installs are not required at the end point VMs.

Why not just use Bash scripts, then?
Ansible has an edge over Bash scripts because
it features an goal-oriented resource model that
describes the desired state of computer systems and services,
not the paths to get them to this state.
No matter what state a system is in, Ansible understands how to transform it to the desired state.
Ansible is a simple to understand [configuration management approach][44].

Ansible just uses a list of tasks to run in YAML2 format.
Ansible also comes with [idempotency][45] out of the box.
That means you can run the same operation numerous times,
and the output will remain consistent
(i.e. it won't do something twice unless you ask it to).
You can write Bash scripts this way, but it requires quite a bit more overhead.

One important feature in Ansible is that a playbook describes a
desired state in a computer system,
so a playbook can be run multiple times against a server without impacting its state.
If a certain task has already been implemented (e.g., "user system already exists"),
then Ansible simply ignores it and moves on.

* **Tasks:** A task is the smallest unit of work.
It can be an action like "Install a database," "Install a web server,"
"Create a firewall rule," or "Copy this configuration file to that server."
* **Plays:** A play is made up of tasks. For example, the play
"Prepare a database to be used by a web server" is made up of tasks
(1) Install the database package,
(2) Set a password for the database administrator,
(3) Create a database; and 4) Set access to the database.
* **Playbook:** A playbook is made up of plays.
A playbook could be "Prepare my website with a database backend" and the plays would be
(1) Set up the database server,
(2) Set up the web server.
* **Roles:** Roles are used to save and organize playbooks and allow sharing and reuse of playbooks.
Following the previous examples, if you need to fully configure a web server,
you can use a role that others have written and shared to do just that.
Since roles are highly configurable (if written correctly),
they can be easily reused to suit any given deployment requirements.
* **Ansible Galaxy:** Ansible Galaxy is an online repository where roles are uploaded so they can be shared with others. It is integrated with GitHub, so roles can be organized into Git repositories and then shared via Ansible Galaxy.

#### Step X: Create Your Directory Structure - DONE

I not only want to create a virtual machine with Vagrant to perform my NeoVim experimentation,
but also setup a directory where I can keep all my documentation and tools permanently.

```bash
# create your working directory
mkdir -p ~/src/test-env/nvim
cd ~/src/test-env/nvim

# create a directory for ansible playbooks
mkdir -p ~/src/test-env/nvim/playbooks
```

#### Step X: Create Your Vagrant Test Environment - DONE

Now create your Vagrantfile within `~/src/test-env/nvim/Vagrantfile`.
That file is listed below:

```
<---- Vagrantfile
```

While in `~/src/test-env/nvim`,
you create your virtual machine for NeoVim testing by executing `vagrant up`.
Once this process completes, you can validate your virtual machine is ready by
`vagrant ssh` which should log you into the machine.

Make sure to update the static IP addresss in the `Vagrantfile`.
This virtual machine is configured with a static IP address (`192.168.1.250`)
since this is required for smooth operation of Ansible.
You'll also notice that the `Vagrantfile` also supplies a SSH key which will be
used by Ansible to gain access to perfrom its provisioning task.

If you need to update the Vagrant box being used,
below are the commands you'll need:

```bash
# updates the current vagrant environment if there are updates available
vagrant box update

# other useful vagrant cli commands

# list the boxes you have installed
vagrant box list

# check if there are updates available for all boxes
vagrant box outdated --global

# remove the older ubuntu/xenial64 box
vagrant box remove ubuntu/xenial64 --box-version=20180410.0.0

# first destroy the vm referenced above
vagrant destroy ce0a38ee8cf347e1a125ea0cad47d28f
```

#### Step X: Establish the Ansible Playbooks

Create the following files to support Ansible:

##### Inventory File - DONE

Establish the `inventory` file which will be used by all the Ansible Playbooks:

```
<---- Inventory File
```

##### Ping & Query Playbooks - DONE

Create a `ping.yml` playbook so you can easily valiate the virtual machine is up
and the SSH keys are working:

```
<---- Ping Playbook
```

```
<---- Query Playbook
```

```bash
# run the playbooks
ansible-playbook -i inventory ping.yml
ansible-playbook -i inventory query.yml
```

[01]:https://codeinthehole.com/tips/debugging-vim-by-example/
[02]:https://en.wikipedia.org/wiki/Cargo_cult
[03]:https://en.wikipedia.org/wiki/Cargo_cult_programming

[30]:https://www.virtualbox.org/
[31]:https://www.virtualbox.org/wiki/Virtualization
[32]:https://en.wikipedia.org/wiki/Hardware-assisted_virtualization
[33]:https://en.wikipedia.org/wiki/Virtual_machine
[34]:https://docs.oracle.com/cd/E97728_01/E97727/html/vboxmanage-intro.html
[35]:https://www.vagrantup.com/
[36]:https://www.vagrantup.com/docs/vagrantfile/
[37]:https://www.vagrantup.com/docs/
[38]:https://www.chef.io/
[39]:https://puppet.com/
[40]:https://saltstack.com/
[41]:https://www.terraform.io/
[42]:https://cfengine.com/
[43]:https://medium.com/@cabot_solutions/ansible-and-docker-the-best-combination-for-an-efficient-software-product-management-28c86cfebe90
[44]:https://www.ansible.com/use-cases/configuration-management
[45]:https://stackoverflow.com/questions/1077412/what-is-an-idempotent-operation
