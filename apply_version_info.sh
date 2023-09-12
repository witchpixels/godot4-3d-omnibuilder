#!/bin/bash
if [[ -f "GitVersion.yml" || -f "../GitVersion.yml" ]]; then
    echo "Found GitVersion.yml"

    echo "We need to do a fetch here because normally we don't have tags which gitversion needs to evaluate. Don't panic, please."
    if [[ -f "GitVersion.yml" ]]; then
        git config --global --add safe.directory $(pwd)
    elif [[ -f "../GitVersion.yml" ]]; then
        git config --global --add safe.directory "$(pwd)/../"
    fi
    git fetch --prune --unshallow || echo "Looks like that was unneeded... oh well!"


    echo "Running gitversion to retrieve FullSemVer and AssemblySemVer"
    export SEMVER=$(dotnet-gitversion | jq .FullSemVer)
    export ASSEMBLY_SEMVER=$(dotnet-gitversion | jq .AssemblySemVer)

    echo "Stamp version $SEMVER in project"
    cat ./project.godot | sed "/^config\\/version=/s/=.*/=$SEMVER/" > ./project.godot.2
    cp ./project.godot.2 ./project.godot
    rm ./project.godot.2

    echo "Stamp version $ASSEMBLY_SEMVER into export_presets.cfg"
    cat ./export_presets.cfg | sed "/^application\\/file_version=/s/=.*/=$ASSEMBLY_SEMVER/" > ./export_presets.cfg.2
    cat ./export_presets.cfg.2 | sed "/^application\\/product_version=/s/=.*/=$ASSEMBLY_SEMVER/" > ./export_presets.cfg.3
    cp ./export_presets.cfg.3 ./export_presets.cfg
    rm ./export_presets.cfg.3
    rm ./export_presets.cfg.2

else
    echo "$(pwd)/GitVersion.yml was not found"
    exit 1
fi

