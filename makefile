build: ./*
	nix-shell --run "nixos-generate -f iso -o ./result -c configuration.nix"

test:
	qemu-system-x86_64 -boot d -cdrom result/iso/nixos.iso -m 512