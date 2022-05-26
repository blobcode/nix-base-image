build: *
	nix-shell --run "nixos-generate -f iso -o ./result -c configuration.nix"