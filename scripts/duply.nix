#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=/root/.nix-defexpr/channels/nixpkgs-22_05
#! nix-shell -i bash -p duply pkgs.python39Packages.boto

exec -a "$0" duply "$@"
