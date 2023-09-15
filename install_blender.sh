 #!/bin/bash

apt install xorg
apt install xz-utils

wget https://download.blender.org/release/Blender3.0/blender-3.0.0-linux-x64.tar.xz
tar -xJf ./blender-3.0.0-linux-x64.tar.xz

mv ./blender-3.0.0-linux-x64 /opt/blender