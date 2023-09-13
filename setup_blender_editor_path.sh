#!/bin/bash
echo $(which blender)
echo "EDITOR SETTINGS BEFORE ---------------------------------"
cat ~/.config/godot/editor_settings-4.tres
echo "-------------------------------------------------------"

echo "filesystem/import/blender/rpc_port = 0" >> ~/.config/godot/editor_settings-4.tres
echo "filesystem/import/blender/rpc_server_uptime = 5" >> ~/.config/godot/editor_settings-4.tres
echo "filesystem/import/blender/blender3_path = \"$(dirname $(which blender))\"" >> ~/.config/godot/editor_settings-4.tres

echo "EDITOR SETTINGS AFTER ---------------------------------"
cat ~/.config/godot/editor_settings-4.tres
echo "-------------------------------------------------------"