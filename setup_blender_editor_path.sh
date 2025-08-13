#!/bin/bash
source /etc/profile
godot -v -e --quit --headless

echo $(which blender)
echo "EDITOR SETTINGS BEFORE ---------------------------------"
cat "${GODOT_EDITOR_SETTINGS_PATH}"
echo "-------------------------------------------------------"

echo "filesystem/import/blender/rpc_port = 6011" >> "${GODOT_EDITOR_SETTINGS_PATH}"
echo "filesystem/import/blender/rpc_server_uptime = 500" >> "${GODOT_EDITOR_SETTINGS_PATH}"
echo "filesystem/import/blender/blender_path = \"$(which blender)\"" >> "${GODOT_EDITOR_SETTINGS_PATH}"

echo "EDITOR SETTINGS AFTER ---------------------------------"
cat "${GODOT_EDITOR_SETTINGS_PATH}"
echo "-------------------------------------------------------"