#!/bin/bash
echo "Using Godot Version $GODOT_VERSION.$RELEASE_NAME"

ls -la /root/.local/share/godot/templates/

# fix template directories, which are wrong in the source image for some reason.
mkdir -v -p /root/.local/share/godot/export_templates
cp -rv /root/.local/share/godot/templates/* /root/.local/share/godot/export_templates/
ls -la /root/.local/share/godot/export_templates/
