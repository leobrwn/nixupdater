#!/usr/bin/env bash
set -uo pipefail

update() {
    printf "Updating channel...\n"
    sudo nix-channel --update

    printf "Switching...\n"
    sudo nixos-rebuild switch || exit 1

    printf "Collecting garbage...\n"
    sudo nix-collect-garbage -d > /dev/null 2>&1 || { echo "Garbage collection failed"; exit 1; }

}

update
