default: 
	just --list

alias r := rebuild
alias v := vim
alias u := update

rebuild:
	sudo nixos-rebuild switch --flake .#

vim:
  nix flake lock --update-input nixvim

update:
	nix flake update
