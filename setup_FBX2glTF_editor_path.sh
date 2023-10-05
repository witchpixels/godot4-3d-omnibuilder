#!/bin/bash

godot -v -e --quit --headless

echo $(which FBX2glTF)
echo "EDITOR SETTINGS BEFORE ---------------------------------"
cat /root/.config/godot/editor_settings-4.tres
echo "-------------------------------------------------------"

echo "filesystem/import/fbx/fbx2gltf_path = \"/usr/local/bin/FBX2glTF\"" >> /root/.config/godot/editor_settings-4.tres

echo "EDITOR SETTINGS AFTER ---------------------------------"
cat /root/.config/godot/editor_settings-4.tres
echo "-------------------------------------------------------"