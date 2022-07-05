#! /usr/bin/env -S nix shell nixpkgs#bash qnixpkgs#duply -c bash

exec -a "$0" duply "$@"
