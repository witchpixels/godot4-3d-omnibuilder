ARG GODOT_VERSION="4.4"
ARG RELEASE_NAME="stable"

FROM barichello/godot-ci:${GODOT_VERSION}
LABEL author="https://github.com/witchpixels/godot4-3d-omnibuilder/graphs/contributors"

ARG GODOT_VERSION
ENV GODOT_VERSION=${GODOT_VERSION}

ADD setup_editor_settings_version.sh /opt/scripts/setup_editor_settings_version.sh
RUN bash /opt/scripts/setup_editor_settings_version.sh

# install dotnet-sdk
ADD install_dotnet_sdk.sh /opt/scripts/install_dotnet_sdk.sh
RUN bash /opt/scripts/install_dotnet_sdk.sh

ENV PATH="/github/home/.dotnet/tools:/root/.dotnet/tools:${PATH}"

RUN apt-get update

# Some Common tool dependencies
RUN apt-get install -y xz-utils curl build-essential

# Install Scons for GdExtension Users
RUN apt-get install -y scons

# Install Rustup for GdRust Users
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
ENV PATH="/home/github/.cargo/bin:/root/.cargo/bin:${PATH}"

# Install wasm toolchain for rust web exports
RUN rustup toolchain install nightly
RUN rustup component add rust-src --toolchain nightly
RUN rustup target add wasm32-unknown-emscripten --toolchain nightly

# Install emsdk for anyone who needs it for building wasm components
ADD setup_emsdk.sh /opt/scripts/setup_emsdk.sh 
RUN bash /opt/scripts/setup_emsdk.sh 
ENV PATH="/emsdk/upstream/emscripten:/emsdk/node/22.16.0_64bit/bin:/emsdk:${PATH}"

# A tool we use for pulling apart version strings
RUN apt-get install -y jq

# install the dependencies for blender, we will use the one installed via downloads
RUN apt-get install -y xorg
RUN apt-get install -y blender

# install blender and also setup blender's path in editor settings so that you can use the inbuilt blender importer
ENV BLENDER_VERSION="4.5.1"

ADD install_blender.sh /opt/scripts/install_blender.sh
RUN bash /opt/scripts/install_blender.sh

ENV PATH="/opt/blender:${PATH}"
ADD setup_blender_editor_path.sh /opt/scripts/setup_blender_editor_path.sh
RUN bash /opt/scripts/setup_blender_editor_path.sh

# This script is there to fixup paths for github runners, which annoyingly 
# seem to nuke the home dir we preconfigured in previous versions.
ADD setup_github_paths.sh /opt/scripts/setup_github_paths.sh 

# Finally, the optional script to stamp versions if you need it
ADD apply_version_info.sh /opt/scripts/apply_version_info.sh

ENV PATH="/opt/scripts:${PATH}"