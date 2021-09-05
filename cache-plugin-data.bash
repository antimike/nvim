#!/bin/bash
# Functions to assist in caching and queuing a vim / neovim plugin
# Can either be sourced and called directly or called via wrapper script

# "Public" (exported) global variables
export STAGING_DIR="$HOME/.q"
export PLUGINS="${STAGING_DIR}/plugins.tsv"
export -A PLUGIN_ENV=(
    [NAME]=
    [URL]=
    [CATEGORY]=
    [PRIORITY]=
    [STARS]=
    [CONFIGS]=PLUGIN_CONFIGS
    [DESCRIPTION]=
    [REQUIRES]=PLUGIN_REQUIRES
)

export PLUGIN_TEMPLATE="$HOME/.config/nvim/template.yaml"
if ! [ -r "$PLUGIN_TEMPLATE" ]; then
    echo "Template file not found" >&2
    exit -1
fi

# "Private" global variables
declare ERR_EXIT=1
declare -A DELIMS=( 
    [col]='	'       # Tab
    [kvpair]=":" 
    [list]="," 
)

######################
## "Public" functions
######################

_add() {
    cat "$PLUGIN_TEMPLATE" | env
}

#######################
## "Private" functions
#######################

__envsubst_plugin() {
    :
}

__error() {
    # Prints error message to stderr and exits
    # Calculates unique error code for each invocation in script based on line
    # number (so should only be invoked once per line)
    # Supports rudimentary templating: %Q is replaced by "queue '${QFILE}'"
    local context=( $(caller 0) )
    local -i errorno="$(grep -n "${FUNCNAME[0]}" "${context[2]}" |
        grep -n "${context[0]}" | cut -f1 -d':')"
    local msg="$(sed "s/%P/${PLUGIN_NAME}/g" <<<"$*")"
    echo "ERROR: $(caller 0): ${msg}"
    exit $errorno
} >&2

###############
## Main script
###############

main() {
    local fn="_$1"
    shift
    $fn "$@"
    exit $?
}

main "$@"
