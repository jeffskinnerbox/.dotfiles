# EXPERIMENTAL
#
# If you install fzf, ripgrep, and bat, you can use the following awesome command to
# fuzzy search your file system and open the matched lines in your favorite text editor.
# This scrip opens files in $EDITOR or defaults to nano.  You can change the editor if you wish.
#
# To use the script, simply change to a directory that contains text files and the letter "s."
# While this command will accept plain old words for search terms,
# you can dramatically boost its accuracy by using Regex.
#
# Boost Your Linux Terminal Productivity by Learning This Advanced Search Syntax - https://www.howtogeek.com/get-started-with-regex-in-linux-terminal/
# 6 Alternative CLI Tools I Immediately Install on Linux - https://www.howtogeek.com/alternative-cli-tools-i-immediately-install-on-linux/
#
# bat: Like cat, But Better
# ripgrep: grep on Steroids
# delta: ripgrep on Steroids — Now on Steroids
# fd: A Faster find With Prettier Colors
# eza: A Modern Replacement for ls
# fzf: The Shell Is Unusable Without fzf History Search
#
# sudo apt install bat ripgrep delta fd eza fzf

function s() {
  fzf --ansi --disabled \
    --bind "change:reload:command \
          rg --line-number --no-heading --color=always --smart-case {q} \
          || :" \
    --bind "enter:execute(${EDITOR:-nano} +{2} {1})" \
    --delimiter ":" \
    --preview "command bat -p --color=always {1} --highlight-line {2}" \
    --preview-window 'up:80%,border-bottom,~3,+{2}+3/3'
}
