# Godot4 3d Omnibuilder Image
Tired of fussing around dependencies with the godot-ci container? Tired of C# feeling like a second class citizen? Take heart! the 3d Omnibuilder is here to help!

Most of this is based on the work done on the work done by [aBarichello's godot-ci project](https://github.com/abarichello/godot-ci/), but what I wanted was a *highly* opinionated, low configuration, turnkey build image. Ideally I just wanted a build script that pulls the repo and runs a single command to build per platform.

## What does it do
The image here extends `barichello/godot-ci`'s mono image, and does a few things:
 1. Installs dotnet sdk 6.0
 2. Install blender
 3. Sets the blender path in EditorSettings
 4. Install's gitversion and provides a script, `apply_version_info.sh` which will stamp Full Sever into `application/config/version` in project settings as well as wherever makes sense in export_presets.cfg.