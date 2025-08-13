#!/bin/bash
mkdir -pv /github/home/
cp -Lrvu /root/* /github/home/
chown -R "$USER" "$HOME"