#!/bin/bash
echo "Using Godot Version $GODOT_VERSION.$RELEASE_NAME"

ls -la /root/.local/share/godot/templates/$GODOT_VERSION.$RELEASE_NAME.mono
# fix template directories, which are wrong in the source image for some reason.

mkdir -v -p /root/.local/share/godot/export_templates
cp -rv /root/.local/share/godot/templates/$GODOT_VERSION.$RELEASE_NAME.mono /root/.local/share/godot/export_templates/$GODOT_VERSION.$RELEASE_NAME.mono

# For GitHub we'll add one more copy to pre-setup the export templates for github's user
mkdir -v -p /github/home/.local/share/godot/export_templates
cp -rv /root/.local/share/godot/templates/$GODOT_VERSION.$RELEASE_NAME.mono /github/home/.local/share/godot/export_templates/$GODOT_VERSION.$RELEASE_NAME.mono

ls -la /github/home/.local/share/godot/export_templates/$GODOT_VERSION.$RELEASE_NAME.mono
ls -la /root/.local/share/godot/export_templates/$GODOT_VERSION.$RELEASE_NAME.mono

# Similarily, we need to do this with the editor settings
godot -v -e --quit --headless

mkdir -v -p /github/home/.config/godot/
cp /root/.config/godot/editor_settings-4.tres /github/home/.config/godot/editor_settings-4.tres
