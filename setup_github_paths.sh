#!/bin/bash
if [[ "$HOME" == "/root" ]] 
then
    echo "Current user's ($USER) home folder is /root... nothing to do."
    exit 0
fi

mkdir -pv "$HOME"
ln -sv /root/* "$HOME"
ln -sv /root/.* "$HOME"
chown -R "$USER" "$HOME"