#!/bin/bash

if [ -f ~/.config/onedrive/config ] ; then
    echo "Onedrive on this computer already configured, exiting."
else
    mkdir -p ~/.config/onedrive
    echo "skip_dir = \"Pictures|Obrazy|Video|Mama-backup\"" > ~/.config/onedrive/config

    onedrive --synchronize
    systemctl --user enable onedrive
    systemctl --user start onedrive
    systemctl status --user onedrive
fi
