<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<!--
<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>
-->


---------------


# What Are 'Checker Files'?

There are many configuration files that contain rules to support static analysis tools
like syntax checkers, linters, and code formatting tools that I use.
Most of them have configuration files to express rules that will be applied or supressed when executed.

With few exceptions, I apply the same rules on all my work.
Therefore, I want to write those rules once and used them unchanged nearly everywhere
and I need to place them in my file system where thay will be applied globally to all my files.

I use this directory to hold these files and I create a symlink to the file.
For example:

```bash
# place these files in the root directory of your account so they are picked-up no matter where your project is located
cd $HOME

# make symbolic links to the configuration files
ln -s $HOME/.dotfile/checker-files/.markdownlint-cli2.jsonc .markdownlint-cli2.jsonc
```

```bash
# go to the directory where you want create a rules file
cd ~/src/my-project

# create the default rules file
ln -s ~/.dotfile/checker-files/.markdownlint.yml .markdownlint.yml
```

If you don't want to use this default file, just break the symbolic start a new file
or copy the default file and make edits to it.
For example:

```bash
# go to the directory where the rules file resides
cd ~/src/my-project

# break the symbolic link to the rules file
unlink .markdownlint.yml

# OR

# copy rules file for custom editing
cp .markdownlint.yml tempfile
unlink .markdownlint.yml
mv tempfile .markdownlint.yml
```

----


# Static Analysis

Static Analysis (also known as static code analysis)
is a method of analyzing computer programs pre-production (aka without running them).
Static Analysis helps you identify maintainability issues
and security vulnerabilities early in the software development life cycle.

How it works

* Static analysis tools examine the source code of a program
* They compare the code to coding standards and best practices
* They identify issues with security, performance, design, and coding style
* They report issues to developers

Why it's useful

* Static analysis helps developers identify issues early in the development process
* It helps ensure that code is safe, secure, and compliant with standards
* It helps new developers onboard faster
* It helps organizations maintain a readable codebase


## Code Linter

A code linter is static analysis tool that analyzes source code for errors, vulnerabilities, and stylistic issues.
Generally, a linter will not change your code, only flag the issues it identifies
and leaving changes to be done manually.
Linters are static code analyzers that work outside of a compiler.

How do linters work?

* Compare code to a set of predefined rules
* Notify the user of issues
* Provide details to help the developer examine the issue

Why use linters?

* Catch issues early: Linters help developers find issues before code is pushed to production
* Improve code quality: Linters help ensure code isby clean and readable
* Make code easier to maintain: Linters help make code easier to understand and maintain
* Reduce technical debt: Linters help developers save time and money by reducing technical debt


## Code Formatter

A code formatter is a tool that automatically formats source code according to
predefined style guidelines, ensuring consistent indentation, spacing, line breaks,
and other formatting aspects across a codebase.
This makes it easier to read and understand by developers.
Essentially, it helps enforce a consistent coding style by automatically adjusting the visual appearance of the code.

Key points about code formatters:

* **Function:** They automatically adjust code formatting based on set rules, like indentation, spacing, line breaks, and brace placement.
* **Benefits:** Improves code readability, simplifies code reviews by ensuring consistency, and reduces time spent on manual formatting.
* **Integration:** Often integrated into development environments (IDEs) and can be used as a part of the build process.

