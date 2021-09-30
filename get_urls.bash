#!/bin/bash

get_urls () { 
    local fname="$1" url=;
    url="$(yq -r '.url' "$fname")" || { 
        echo "Whoops" 1>&2;
        return 1
    };
    echo "Obtaining repository URLs from API endpoint '$url'..." >&2
    yq -i -S -Y '.urls=$urls[] | del(.url)'  "$fname" --slurpfile urls <(get_url_arr "$url")
}

_jsonify_arg() {
    local -a _hist_=( )
    local -n log=_hist_
    while getopts ":l:" opt; do
        case "$opt" in
            l) local -n log="$OPTARG" || return -1 ;;
            *) echo "Unknown opt '${OPTARG}'" ;;
        esac
    done
    shift $(( OPTIND - 1 )); OPTIND=1

    if [ $# -gt 1 ]; then
        local -a args=( "$@" )
        _jsonify_arg args
        return $?
    fi
    { local -n ref="$1" && declare -p "${!ref}"; } >/dev/null 2>&1 || 
        { printf '"%q"' "$1"; return 0; }
    case "${ref@a}" in
        *a*)        # Array
            printf '['
            for elem in "${ref[@]}"; do
                printf "$(_jsonify_arg "$elem"),"
            done | sed 's/,$//'
            printf ']'
            log+=( "Added ${#ref[@]} item(s) to array \"${!ref}\"" )
            ;;
        *A*)        # Associative array
            printf '{'
            for key in "${!ref[@]}"; do
                printf '"%s":%s,' \
                    "$key" \
                    "$(_jsonify_arg "${ref[$key]}")"
            done | sed 's/,$//'
            printf '}'
            log+=( "Added ${#ref[@]} items to dict \"${!ref}\"" )
            ;;
        *i*)        # Integer
            printf "$ref"
            log+=( "Added item \"${!ref}\" with value $ref" )
            ;;
        *)          # Anything else gets treated as string
            printf '"%s"' "$ref"
            log+=( "Added item \"${!ref}\" with value \"$ref\"" )
            ;;
    esac
    return $?
}

add_attrs() {
    local -a files=( )
    local -A attrs=( )
    local -a props=( )
    local -a hist=( )
    local propname="props"

    while [ $# -gt 0 ]; do
        case "$1" in
            --files) shift; files+=( "$@" ); break ;;
            -n|--propname) propname="$2"; shift ;;
            *=*) attrs["${1%%=*}"]="${1#*=}" ;;
            *:*) attrs["${1%%:*}"]="${1#*:}" ;;
            *)
                if declare -p "$1" >/dev/null 2>&1; then
                    attrs["$1"]="$1"
                else
                    props+=( "$1" )
                fi
                ;;
        esac
        shift
    done

    local -a opts=( -Y -S )
    local script='
        (.)+=$ARGS.positional[0] |
        .history+={(now|todate): ["Added \($vs | length) items to \"\($n)\""]}
        '

    if [ ${#files[@]} -gt 0 ]; then
        opts+=( -i )
    fi

    if [ ${#props[@]} -gt 0 ]; then
        attrs["$propname"]=props
    fi

    local json="$(_jsonify_arg -l hist attrs)"

    local -a cmd=( 
        jq "${opts[@]}" "$script" --jsonargs "$json" "$(_jsonify_arg hist)" 
    )
    
    local -n vals="$1" && shift || return -1
    for f in "$@"; do
        yq -Y -S -i  "$f" --args "${!vals}" "${vals[@]}"
    done
}

convert_timestamp() {
    local search="$1" && shift
    local fmt="%Y-%m-%dT%H:%M:%SZ"
    for f in "$@"; do
        ts="$(yq '.history | keys[] | select(.|test($search))' "$f" \
            --arg search "$search" | 
            xargs -I {} date "+${fmt}" -d {})"
        yq -S -i -Y '.history += (.history |
            with_entries(select(.key|test($search))|.key=($ts))) |
            delpaths([paths | select(.[-1] | strings | test($search))])' \
            "$f" \
            --arg search "$search" --arg ts "$ts"
    done
}
