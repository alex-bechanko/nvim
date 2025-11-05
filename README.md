# Alex Bechanko's Neovim Configuration

## Usage
This repository uses [Nix](https://nixos.org/) for package and build management, specifically this repository is a
[flake](https://wiki.nixos.org/wiki/Flakes).
The flake provides a Neovim package, Home-Manager and NixOS module that can be used in your own Nix configuration.

## Architecture
This flake uses [NixCats](https://nixcats.org/) to define and install Neovim plugins.
NixCats enables me to organize my Neovim plugins, language servers, linters, formatters, and other dependencies into
groups related to the language they support.
As such, I currently have 5 categories:

1. general
2. rust
3. nix
4. lua
5. go

## License
Usage is licensed under the MIT license
