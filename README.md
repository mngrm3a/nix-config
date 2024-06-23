# Usage

It is not necessary to install Home Manager as it is the default package of this flake. Running `nix run . --` will execute Home Manager, and all arguments following `--` will be passed to it. Home Manager provides a `--flake` option that allows you to select an attribute to be used as the configuration. The `.` refers to the first attribute in `packages.homeConfigurations`.

* build configuration: `nix run . -- build --flake .`
* switch to configuration: `nix run . -- switch --flake .`
* use `$SHELL` instead of bash: `nix develop`

# References

## NixOs setup with nix-darwin

* https://github.com/mitchellh/nixos-config

## Standalone Home Manager setup

* [Self contained flake](https://www.chrisportela.com/posts/home-manager-flake/)
* [UI to search options](https://home-manager-options.extranix.com)
* [home.state](https://nix-community.github.io/home-manager/options.xhtml#opt-home.stateVersion)
