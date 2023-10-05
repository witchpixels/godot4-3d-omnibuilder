 #!/bin/bash
DESIRED_FBX2GLTF_VERSION=$1

if [[ -z "$DESIRED_FBX2GLTF_VERSION" ]]; then
    echo "no FBX2glTF version supplied, installing $FBX2GLTF_VERSION"
    DESIRED_FBX2GLTF_VERSION=$FBX2GLTF_VERSION
else
    echo "installing FBX2glTF $DESIRED_FBX2GLTF_VERSION over $FBX2GLTF_VERSION"
fi

wget -O FBX2glTF.zip https://github.com/godotengine/FBX2glTF/releases/download/v${DESIRED_FBX2GLTF_VERSION}/FBX2glTF-linux-x86_64.zip 
unzip FBX2glTF.zip 

mv FBX2glTF-linux-x86_64/FBX2glTF-linux-x86_64 /usr/local/bin/FBX2glTF
rm FBX2glTF.zip