#!/bin/bash
echo "Using Godot Version $GODOT_VERSION.$RELEASE_NAME"

ls -la /root/.local/share/godot/templates/
# fix template directories, which are wrong in the source image for some reason.

mkdir -v -p /root/.local/share/godot/export_templates
cp -rv /root/.local/share/godot/templates/* /root/.local/share/godot/export_templates/

# For GitHub we'll add one more copy to pre-setup the export templates for github's user
mkdir -v -p /github/home/.local/share/godot/export_templates
cp -rv /root/.local/share/godot/templates/* /github/home/.local/share/godot/export_templates/

ls -la /github/home/.local/share/godot/export_templates/
ls -la /root/.local/share/godot/export_templates/

# in the case of github actions runner, se need to copy the editor settings
mkdir -v -p /github/home/.config/godot/
cp -rv /root/.config/* /github/home/.config/
