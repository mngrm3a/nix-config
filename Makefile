FLAKE_NIX := flake.nix
MODULES_NIX := $(wildcard modules/*)
HOMEMANAGER_NIX := $(wildcard home-manager/*)
ALL_NIX := $(FLAKE_NIX) $(MODULES_NIX) $(HOMEMANAGER_NIX)

build: $(ALL_NIX)
	nix run --show-trace . -- build --flake .

switch: $(ALL_NIX)
	nix run . -- switch --flake .

generations: $(ALL_NIX)
	nix run . -- generations | less

news: $(ALL_NIX)
	nix run . -- news --flake .

PHONY: clean
clean:
	rm result