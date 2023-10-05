ARG GODOT_VERSION="4.1.1"
ARG RELEASE_NAME="stable"

FROM witchpixels/godot4-ci:mono-${GODOT_VERSION}
LABEL author="https://github.com/witchpixels/godot4-3d-omnibuilder/graphs/contributors"

# install dotnet-sdk
ADD install_dotnet_sdk.sh /opt/scripts/install_dotnet_sdk.sh
RUN bash /opt/scripts/install_dotnet_sdk.sh

ENV PATH="/github/home/.dotnet/tools:/root/.dotnet/tools:${PATH}"

RUN apt update

# A tool we use for pulling apart version strings
RUN apt install -y jq

# install the dependencies for blender
RUN apt install -y xorg
RUN apt install -y xz-utils

# install blender and also setup blender's path in editor settings so that you can use the inbuilt blender importer
ENV BLENDER_VERSION="3.6.0"

ADD install_blender.sh /opt/scripts/install_blender.sh
RUN bash /opt/scripts/install_blender.sh

ENV PATH="/opt/blender:${PATH}"
ADD setup_blender_editor_path.sh /opt/scripts/setup_blender_editor_path.sh
RUN bash /opt/scripts/setup_blender_editor_path.sh

# install FBX2glTF and setup path in editor settings
ENV FBX2GLTF_VERSION="0.13.1"

ADD install_FBX2glTF.sh /opt/scripts/install_FBX2glTF.sh
RUN bash /opt/scripts/install_FBX2glTF.sh

ADD setup_FBX2glTF_editor_path.sh /opt/scripts/setup_FBX2glTF_editor_path.sh
RUN bash /opt/scripts/setup_FBX2glTF_editor_path.sh

# Some paths produced in the image are incorrect
ADD setup_templates.sh /opt/scripts/setup_templates.sh
RUN bash /opt/scripts/setup_templates.sh

# This script is there to fixup paths for github runners, which annoyingly 
# seem to nuke the home dir we preconfigured in previous versions.
ADD setup_github_paths.sh /opt/scripts/setup_github_paths.sh 

# Finally, the optional script to stamp versions if you need it
ADD apply_version_info.sh /opt/scripts/apply_version_info.sh

ENV PATH="/opt/scripts/:${PATH}"
