# dotfiles
This repository exists to provide a more portable and structured way of maintaining my dotfiles. Dotfiles are typically configuration files, that can be identified by the `.` prefix in their filenames. These are the configuration files I use to personalize my machine.

Inspired by [Zach Holman](https://github.com/holman/dotfiles).

## Prerequisites
The configurations and aliases are developed assuming [zsh](https://en.wikipedia.org/wiki/Z_shell) as the command interpreter. Without it, the files themselves will be pretty obscelete as is 🙊.

## Getting Started
Clone the repository and run the `install.sh` script.

The script will make a dotfile symbolic link to all the files containing a `.symlink` extension in this repository and the project itself in the `$HOME` directory.

**NOTE:** `.zshrc` is responsible for loading files containing the `.zsh` extension into the environment.
