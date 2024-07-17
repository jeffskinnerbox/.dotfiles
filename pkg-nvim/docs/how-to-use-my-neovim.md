<!-- vim: ts=2 sts=2 sw=2 et                                                            -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->
<!-- markdownlint-disable-file MD007 MD012 MD013 MD022 MD033 MD035 MD041 MD045          -- for the linter 'markdownlint', disable these linting rule, See [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------


Much of what is said here for NeoVim, is also true for Vi and Vim.

Vim keys allow you to stay on keys in the home rows and other keys around that. Therefore, when you use Vim keys, you don’t have to move your fingers a lot. On top of that, most of these keys work in a similar fashion. For example, d$ and y$, 3j, 3d. So, you can memorize them easily. These keys should work on vim, neovim, vi, and any other plugin which provides vim key mappings.

Use the following to execute Neovim: `alias vi="gnome-terminal --title NeoVim -- nvim -p"`


Sources:

* [Vim Cheat Sheet](https://vim.rtorr.com/)
* [How to Use Vim/Neovim](https://smarttech101.com/how-to-use-vim-neovim/)
* [How to Configure Neovim](https://smarttech101.com/how-to-configure-neovim/)



------



# Table of Contents

* What are the Modes in NeoVim
    * Keys in Normal Mode
    * Keys in Insert Mode
    * Keys in Visual Mode
    * Keys in Command Mode
* Macros in NeoVim
* ......

## What are the Modes
Because Vim is focused on changing existing code just as much as writing new code,
it is split into several modes that each have different purposes.
Vim has several types of modes, some of which are:

* **Normal Mode:** It is the mode used when you want to move around your text
using your keys such as `k`, `j`, `h`, `l`, the arrow-keys, etc.
This mode has very limited text enter or delete capabilities.
* **Insert Mode:** To type into your text, you need to get into Insert Mode.
Whatever keys, you press, are typed into your texts body.
* **Visual Mode:** This mode is used to select a chunk of text.
There are various types of visual modes – visual line mode, visual block mode, etc.
* **Replace Mode:** This replace text by typing over it
* **Command Mode:** This mode is used to execute a command or search for a text in vim.
You need to press `:` or `/` to enter the console mode.

To find out the current mode, look at the bottom line, left-hand side in your editor.

### Keys in Normal Mode
By default, Vim starts in Normal mode.
Normal mode can be accessed from other modes by pressing `Esc` or `Ctrl+[` (aka `<C-[>`).

**Cursor Movement**
* Move the cursor one character position
    * `h` move one character left
    * `j` move one row down
    * `k` move one row up
    * `l` move one character right
    * arrow-keys can do same
* Move the cursor multiple character position
    * `4j` move 4 rows down
    * `6k` move 6 rows up
* Word movements
    * `w` move to beginning of next word
    * `b` move to previous beginning of word
    * `e` move to end of word
    * `W` move to beginning of next word after a whitespace
    * `B` move to beginning of previous word before a whitespace
    * `E` move to end of word before a whitespace
* Line movement
    * `0` or `^` move to the beginning of the line
    * `$` move to the end of the line
* Block movement
    * `}` jump to the next paragraph/function/block in code or texts
    * `{` jump in the reverse direction
* Matching pair movement
    * `%` move to the matching characters of `(` & `)`, `[` & `]`, `{` & `}`
* Screen movement
    * `zz` shift text so the cursor location is in the middle of the screen
    * `Ctrl+b` move backward one full screen
    * `Ctrl+u` move backward 1/2 a screen
    * `Crtl+f` move forward one full screen
    * `Crtl+d` move forward 1/2 a screen
* File movement
    * `gg` move to the first line of the file
    * `G` or `$G` move to the last line of the file
    * `nG` to move to the n’th line of the file
**Character(s) Replacement**
* Single characters changes
    * `r` replace character under the cursor
    * `x` delete character under the cursor
* Multiple characters changes
    * `R` start replacing character under the cursor as you type (this is Replace Mode)
**Cut & Paste**
* Yank text (aka copy to clipboard and then delete text)
    * `y` select texts using the Visual mode and then pressing
    * `yy` yank the whole line, no need to select any text here
    * `nyy` yank the n line,s no need to select any text here
    * `y$` yank text from current cursor position to end of line
* Paste text from clipboard
    * `p` after yanking/cutting, paste the clipboard in the line after the cursor
    * `P` after yanking/cutting, paste the clipboard in the line before the cursor
**Redo or Undo command**
* Redo last changes made in Normal, Insert, Visual modes
    * `.` repeat the last command or group of commands
* Undo last changes made in Normal, Insert, Visual modes
    * `u` undoes changes up to the last time you were in Normal mode
    * `Ctrl+r` undo your undo in Normal mode

### Keys in Insert Mode
Once in Insert mode, typing inserts characters just like a regular text editor.
You can enter it by using an Insert command from Normal mode.

* Insert mode at current location
    * `i` for ’insert’, this moves the cursor *before the current character* and enters Insert mode
    * `I` moves the cursor to the *beginning of the line* and enters insert mode
    * `a` for ’append’, this moves the cursor *after the current character* and enters Insert mode
    * `A` moves the cursor to the *end of the line* and enters insert mode
    * `o` inserts a new line *below the current line* and enters insert mode on the new line
    * `O` inserts a new line *above the current* one and enters insert mode on the new line
* Change lines and words
    * `cc` change (replace) the entire line
    * `c$` change (replace) to the end of the line
    * `cw` or `ciw` change (replace) the entire word
* Join lines
    * `J` join the line below to the current one with one space in between
    * `gJ` join the line below to the current one without space in between

There are many more ways of inserting text but these are the simplest.

To leave Insert mode and return to Normal mode, press `Esc` or `Ctrl+[`.

### Keys in Visual Mode
Visual mode is used to make selections of a block of text.
Selecting text allows commands to apply only to the selection,
such as copying, deleting, replacing, and so on.

* Make a text selection
    * `v` to enter visual mode, this will mark a starting selection point.
    Move the cursor (via keys or mouse) to the desired end selection point.
    A visual highlight of the text selected will be made.
    * `V` to enter visual line mode, this will make text selections by line
    * `Ctrl+V` to enter visual block mode, this will make text selections by blocks.
    moving the cursor will make rectangle selections of the text.

To leave Visual mode and return to Normal mode, press `Esc` or `Ctrl+[`.

### Keys in Replace Mode
Replace mode allows you replace existing text by directly typing over it.
Before entering this mode, get into Normal mode and put your cursor on top of the
first character that you want to replace.

* Multiple characters changes
    * `R` start replacing character under the cursor as you type.
    Now whatever you type will replace the existing text.
    The cursor automatically moves to the next character just like in Insert mode.
    The only difference is that every character you type will write over the existing one.

To leave Replace mode and return to Normal mode, press `Esc` or `Ctrl+[`.

### Keys in Command Mode
Command mode has a wide variety of commands,
and can do things that no other mode can’t do as easily.
To enter command mode type `:` from Normal mode
and then type your command which should appear at the bottom of the window.
For example, to do a global find and replace type :%s/foo/bar/g to replace all ‘foo’ with ‘bar’

**?????**

* Saving & quit buffers
    * `:` Enters command mode, next set of characters will be the command to execute
    * `:w` write a buffer to its respective file
    * `:wa` write all buffers to its respective files
    * `:w <filename>` write a buffer to a named file
    * `:w !sudo tee %` write out the buffer to its file using `sudo`
    * `:q` assuming you have saving changes to the file, leave the buffer
    * `:q!` regardless if you have saving changes to the file, leave the buffer
    * `:qa` assuming you have saving changes to the files, leave all the buffers
    * `:qa!` regardless you have saving changes to the files, leave all the buffers
* Search for a pattern
    * `/` Enters command mode, next set of characters will be search forward
    * `?` Enters command mode, next set of characters will be search backward
    * `n` to progressively continue the search forward or backward
* ???
    * `:%` Means across all lines
    * `s` Means substitute
    * `:%s/xxx/yyy/` find 'xxx' and replace with 'yyy' accross all lines
    * `/foo` is regex to find things to replace
    * `/bar/` is regex to replace things with
    * `/g` means global, otherwise it would only execute once per line
* Ed commands

**Navigating Buffers and Split Windows**

* Buffers motion
    * `:bn` or `:bnext` go to the next buffer
    * `:bp` or `:bprev` go to the previous buffer
* Split windows
    * `Ctrl+ws` to split the window
* Navigate windows
    * `Ctrl+ww` to switch windows
    * `Ctrl+wq` to quit a window
    * `Ctrl+wv` to split the window vertically
    * `Ctrl+wh` to move the cursor to the left window (vertical split)
    * `Ctrl+wl` to move the cursor to the right window (vertical split)
    * `Ctrl+wj` to move the cursor to lower window


-----


## Macros in NeoVim
With NeoVim Macros, you can record a group of keys at a single key
and execute this key to execute the whole group at any time.
To start recording macros we call `a`, press `qa`.
To record a macro called `b`, press `qb` and so on.
During the recording of the macro,
execute all the Normal/Insert/other mode commands (like `j`, `k`, `y`, `v`, `x`, etc.).
After you are done, quit the recording by pressing `q`.
Now, you can call forth recording called `a` by pressing `@a`,
recording called `b` by pressing `@b`.

For example, suppose you want to remove 5 spaces at the end of each line.
You can go to the beginning of your first line
and press this sequence of keys `qa$xxxxxjq`.
Now, just press `@a` to remove 5 spaces at the end of any line.

To re-run the last run macro, use `@@`.

* Macros
    * `qN` start recording a macro called `N`
    * `q` stop the recording of any active macro recording
    * `@N` execute the macro called `N`
    * `@@` re-run the last macro you used


-----



# Types of Motion

* [Neovim for Beginners — Motion](https://alpha2phi.medium.com/neovim-for-beginners-motion-4553e3c06818)

Vim supports several types of cursor motions:

* Jump Motions (`:help jump-motions`) is a command that normally moves the cursor several lines away.
* Mark Motions (`:help mark-motions`) allows us to record the current position so we can return to it later.
* Word Motions (`:help word-motions`) let you jump from word to word in either direction, and beginning or end of the word.

# Theme
A theme in NeoVim is a color scheme,
which is the set of colors that are used to distinguish controls,
differentiate sections in your source code,
and highlight other aspects of the interface.
NeoVim comes pre-installed with several themes and there are many more available on GitHub.
A list of the most popular Vim color schemes can be found [here][01].

By applying the `:colorscheme` command,
you can change the color scheme to something that makes your text look clear to you.
For example, to change to the built-in “Desert” theme: `:colorscheme desert`.
There are two ways to get a list of all of the installed color schemes,
as follows:

```neovim
:colorscheme <space> <tab>      -- will bring up a list that you can select from
:colorscheme <space> <ctrl-d>   -- will display a text listing of them
```

# Completion

## Built-in Completion

* [Neovim for Beginners — Built-in Completion](https://alpha2phi.medium.com/neovim-for-beginners-built-in-completion-8bbbb0f16c9c)

## Code Completion
Code completion is a feature that is available with the help of LSP.
Intelligent code completion is context-sensitive
and will provide an easy way to access class member functions and variables.
The suggestions are made in real-time, and in many cases,
speed up programming because details like specific class functions no longer need to be memorized.

# Code Snippets
These are small blocks of code that are used often enough to warrant having a quick key combination set up to include them.

# Using LSP / Mason to Manage Language Servers

* [Neovim - LSP Setup Tutorial (Built in LSP 100% Lua)](https://www.youtube.com/watch?v=6F3ONwrCxMg&t=756s)
* [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE)



[01]:https://www.slant.co/topics/480/~best-vim-color-schemes
[02]:
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
[11]:

