ROOT_FILES := flake.nix home.nix
PROGRAM_FILES := $(wildcard programs/*)

build: $(ROOT_FILES) $(PROGRAM_FILES)
	nix run --show-trace . -- build --flake .

switch: $(ROOT_FILES) $(PROGRAM_FILES)
	nix run . -- switch --flake .

PHONY: clean
clean:
	rm result