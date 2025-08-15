# Godot4 3d Omnibuilder Image
Tired of fussing around dependencies with the godot-ci container? Tired of C# feeling like a second class citizen? Frustrated with fiddling with Dockerfiles just so your GDExtension can compile? Take heart! the 3d Omnibuilder is here to help!

Most of this is based on the work done on the work done by [aBarichello's godot-ci project](https://github.com/abarichello/godot-ci/), but what I wanted was a *highly* opinionated, low configuration, turnkey build image. Ideally I just wanted a build script that pulls the repo and runs a single command to build per platform.

## What does it do
The image here extends `barichello/godot-ci`'s mono image, and does a few things:
 1. Installs dotnet sdk 8.0 and 9.0
 2. Install blender's latest LTS version
 3. Sets the blender path in EditorSettings
 5. Install's gitversion and provides a script, `apply_version_info.sh` which will stamp Full Sever into `application/config/version` in project settings as well as wherever makes sense in export_presets.cfg.

 The container also contains and install of `Scons` `Rustup` and `EMSDK` Though if you are using rust, I recommend using `rustup`'s self-update command before compiling to ensure that you have the version of the toolchain that you need for your project.

## Usage

Most everything from [aBarichello's godot-ci project](https://github.com/abarichello/godot-ci/)'s apply, including using butler to upload builds to itch.io, as well as the commands you need to run to export your game. However there are a few additional features that you have at your disposal.

All of thes examples assume your project is in the repository root. If not, add a `cd ./relative/path/to/project` before each command in the runner.

### Simple Usage
If you just want to build your game and the default version of blender installed (3.6.0) works for you, or you don't have any blender files in your project you just need a github actions like the following:

```yaml
name: Export Project
on:
  push:
    branches: [ "main" ]
env:
  EXPORT_NAME: cool_godot_game # change this to whatever you like
jobs: 
  build_project_linux:
    name: Build Project (Linux)
    runs-on: ubuntu-latest
    container:
      image: witchpixels/godot4-omnibuilder3d:latest-4.1.1
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          lfs: true

      # You only need this for Github Actions, Gitlab works out of the box
      - name: Fix paths for Github
        run: setup_github_paths.sh

      - name: Linux Build
        run: |
          mkdir -v -p build/linux
          godot -v --headless --export-release "Linux/X11" build/linux/$EXPORT_NAME.x86_64

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.EXPORT_NAME }}-linux
          path: build/linux
  
  build_project_windows:
    name: Build Project (Windows Desktop)
    runs-on: ubuntu-latest
    container:
      image: witchpixels/godot4-omnibuilder3d:latest-4.1.1
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          lfs: true

      # You only need this for Github Actions, Gitlab works out of the box
      - name: Fix paths for Github
        run: setup_github_paths.sh

      - name: Windows Build
        run: |
          mkdir -v -p build/windows
          godot -v --headless --export-release "Windows Desktop" build/windows/$EXPORT_NAME.exe

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.EXPORT_NAME }}-windows
          path: build/windows
```

### Changing Blender Version
If you need a specific blender version and can't/don't want to wait for me to update it, there is a script `install_blender.sh` that you can call that will install whatever blender version you need and place it in path.

For example, if you want to install Blender 3.6.2

```yaml
name: Export Project Using Blender 3.6.2
on:
  push:
    branches: [ "main" ]
env:
  EXPORT_NAME: cool_godot_game # change this to whatever you like
jobs: 
  build_project_linux:
    name: Build Project (Linux)
    runs-on: ubuntu-latest
    container:
      image: witchpixels/godot4-omnibuilder3d:latest-4.1.1
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          lfs: true

      - name: Install Blender
        run: install_blender.sh 3.6.2

      - name: Linux Build
        run: |
          mkdir -v -p build/linux
          godot -v --headless --export-release "Linux/X11" build/linux/$EXPORT_NAME.x86_64

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.EXPORT_NAME }}-linux
          path: build/linux
  
  build_project_windows:
    name: Build Project (Windows Desktop)
    runs-on: ubuntu-latest
    container:
      image: witchpixels/godot4-omnibuilder3d:latest-4.1.1
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          lfs: true

      - name: Install Blender
        run: install_blender.sh 3.6.2

      - name: Windows Build
        run: |
          mkdir -v -p build/windows
          godot -v --headless --export-release "Windows Desktop" build/windows/$EXPORT_NAME.exe

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.EXPORT_NAME }}-windows
          path: build/windows
```

*NOTE:* You do want to make sure that you run this before the Import Assets step

### Using GitVersion

I use gitversion, maybe you do too! If you do, and don't want to, or haven't yet wrote your own scripts for stamping the version into the build, there is a handy helper script in path called `apply_version_info.sh`.

This will install `dotnet-gitversion`, pull some repo metadata and then write the version string into `export_presets.cfg` for Windows Desktop builds as well as update `application/config/version` in your project if you have set that in your project.

```yaml
name: Export Project
on:
  push:
    branches: [ "main" ]
env:
  EXPORT_NAME: cool_godot_game # change this to whatever you like
jobs: 
  build_project_linux:
    name: Build Project (Linux)
    runs-on: ubuntu-latest
    container:
      image: witchpixels/godot4-omnibuilder3d:latest-4.1.1
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          lfs: true

      - name: Stamp Versions
        run: apply_version_info.sh

      - name: Linux Build
        run: |
          mkdir -v -p build/linux
          godot -v --headless --export-release "Linux/X11" build/linux/$EXPORT_NAME.x86_64

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.EXPORT_NAME }}-linux
          path: build/linux
  
  build_project_windows:
    name: Build Project (Windows Desktop)
    runs-on: ubuntu-latest
    container:
      image: witchpixels/godot4-omnibuilder3d:latest-4.1.1
    steps:
      - name: Checkout
        uses: actions/checkout@v5
        with:
          lfs: true


      - name: Stamp Versions
        run: apply_version_info.sh

      - name: Windows Build
        run: |
          mkdir -v -p build/windows
          godot -v --headless --export-release "Windows Desktop" build/windows/$EXPORT_NAME.exe
          
      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ${{ env.EXPORT_NAME }}-windows
          path: build/windows
```
This script just needs to run before your export.

## Contributing

The main thing I was solving for is getting a one stop solution for using C# on a 3d Game, however if there are other tools that would be beneficial to be pathed in, I'd be happy to add them, or accept PRs that include them.

One note, though:

If you add a new tool, please add something that can be verified in `test_project/validate_imports.sh` to test that it is working. Add any needed addons to the test project as needed, it doesn't need to be pretty.