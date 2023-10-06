#!/bin/bash
find ./.godot/imported/ -name "d20.blend-*.scn" | grep .
find ./.godot/imported/ -name "d20.fbx-*.scn" | grep .
exit $?