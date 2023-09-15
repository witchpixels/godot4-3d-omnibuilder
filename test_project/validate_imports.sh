#!/bin/bash
find ./.godot/imported/ -name "d20.blend-*.scn" | grep .
exit $?