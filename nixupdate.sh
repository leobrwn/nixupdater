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


read -r -p "Do you want to collect garbage? (Y/N/Exit): " YN

case "$YN" in
    [Yy])
        update
        collect
        ;;
    [Nn])
        update
        ;;
    e|E|exit|Exit)
        exit 0
        ;;
    *)
        printf "Invalid option... "
        exit 1
        ;;
esac
