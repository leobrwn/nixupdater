#!/usr/bin/env bash
set -u

update() {
    printf "Updating channel...\n"
    sudo nix-channel --update

    printf "Switching...\n"
    sudo nixos-rebuild switch || exit 1

}

collect() {
    printf "Collecting garbage...\n"
    sudo nix-collect-garbage -d || { printf "Garbage collection failed"; exit 1; }
}


read -r -p "Do you want to collect garbage? (Y/N): " YN

case "$YN" in
    [Yy])
        update
        collect
        ;;
    [Nn])
        update
        ;;
    *)
        printf "Invalid option exiting..."
        exit
        ;;
esac
