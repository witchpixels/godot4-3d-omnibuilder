#!/bin/bash

godot -v -e --quit --headless

echo $(which blender)
echo "EDITOR SETTINGS BEFORE ---------------------------------"
cat /root/.config/godot/editor_settings-4.tres
echo "-------------------------------------------------------"

echo "filesystem/import/blender/rpc_port = 6011" >> /root/.config/godot/editor_settings-4.tres
echo "filesystem/import/blender/rpc_server_uptime = 500" >> /root/.config/godot/editor_settings-4.tres
echo "filesystem/import/blender/blender3_path = \"$(dirname $(which blender))\"" >> /root/.config/godot/editor_settings-4.tres

echo "EDITOR SETTINGS AFTER ---------------------------------"
cat /root/.config/godot/editor_settings-4.tres
echo "-------------------------------------------------------"