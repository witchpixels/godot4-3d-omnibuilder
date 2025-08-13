#!/bin/bash
MONO_PREFIX="mono-"
GD_VERSION=${GODOT_VERSION#"$MONO_PREFIX"}
echo "Your Godot engine version is $GD_VERSION..."
EDITOR_SETTINGS_VERSION="$(echo "$GD_VERSION" | cut -d '.' -f 1).$(echo "$GD_VERSION" | cut -d '.' -f 2)"
if [[ "$(echo "$GD_VERSION" | cut -d '.' -f 2)" == "0" ]] 
then
    EDITOR_SETTINGS_VERSION="$(echo "$GD_VERSION" | cut -d '.' -f 1)"
fi

export GODOT_ENGINE_VERSION=${GD_VERSION}
export GODOT_EDITOR_SETTINGS_PATH="/root/.config/godot/editor_settings-$EDITOR_SETTINGS_VERSION.tres"

echo "Setting editor settings path as $GODOT_EDITOR_SETTINGS_PATH"

if ! grep -q "export GODOT_ENGINE_VERSION=${GD_VERSION}" "/etc/profile"
then
    echo "export GODOT_ENGINE_VERSION=${GD_VERSION}" >> /etc/profile
fi
if ! grep -q "export GODOT_EDITOR_SETTINGS_PATH=${GODOT_EDITOR_SETTINGS_PATH}" "/etc/profile"
then
    echo "export GODOT_EDITOR_SETTINGS_PATH=${GODOT_EDITOR_SETTINGS_PATH}" >> /etc/profile
fi
