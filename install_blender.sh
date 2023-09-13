 #!/bin/bash

apt install xz-utils

wget https://mirrors.ocf.berkeley.edu/blender/release/Blender3.6/blender-3.6.2-linux-x64.tar.xz
tar -xJf ./blender-3.6.2-linux-x64.tar.xz

mv ./blender-3.6.2-linux-x64 /opt/blender