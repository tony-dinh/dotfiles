# dotfiles
This repository exists to provide a more portable and structured way of maintaining my dotfiles. Dotfiles are typically configuration files, that can be identified by the `.` prefix in their filenames. These are the configuration files I use to personalize my machine.

Inspired by [Zach Holman](https://github.com/holman/dotfiles).

## Prerequisites
The configurations and aliases are developed assuming [zsh](https://en.wikipedia.org/wiki/Z_shell) as the command interpreter. Without it, the files themselves are be pretty obscelete as is 🙊.

## Getting Started
Clone the repository and run the `setup.sh` script located in the `scripts` folder.

The script will make a symbolic link to all the dotfiles in this repository and the project itself in the `$HOME` directory.
