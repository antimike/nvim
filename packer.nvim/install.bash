#!/bin/bash

export NVIM_PLUGIN_DIR="${NVIM_PLUGIN_DIR:-$HOME/.local/share/nvim/site/pack}"

main() {
    if mkdir -p "$NVIM_PLUGIN_DIR" || [ -d "$NVIM_PLUGIN_DIR" ]; then
        local url="$(yq -r '.url' info.yaml)"
        local name="$(yq -r '.name' info.yaml)"
        local dest="${NVIM_PLUGIN_DIR}/${name%.*}/start/${name}"
        local -a opts=( --depth 1 )
        git clone "${opts[@]}" "$url" "$dest"
    else
        echo "Unable to locate ${NVIM_PLUGIN_DIR@A}" >&2
        exit 1
    fi
    exit $?
}

main "$@"
