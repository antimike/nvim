#!/bin/bash

export NVIM_PLUGIN_DIR="${NVIM_PLUGIN_DIR:-$HOME/.local/share/nvim/site/pack}"
declare url="$(yq -r '.urls.clone_url' info.yaml)"
declare name="$(yq -r '.name' info.yaml)"
declare dest="${NVIM_PLUGIN_DIR}/${name%.*}/start/${name}"
declare repo="`pwd`/${name}"
declare -a GIT_CMD=(
    git submodule add
)
declare -a GIT_OPTS=(
    --depth 1
)

main() {
    ${GIT_CMD[@]} ${GIT_OPTS[@]} -- "$url" "$repo" &&
        if mkdir -p "$NVIM_PLUGIN_DIR" || [ -d "$NVIM_PLUGIN_DIR" ] 
        then
            ln -s "$repo" "$dest"
        else
            echo "Unable to locate ${NVIM_PLUGIN_DIR@A}" >&2
            exit 1
        fi
    exit $?
}

main "$@"
