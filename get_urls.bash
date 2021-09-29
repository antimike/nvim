#!/bin/bash
get_urls () 
{ 
    local fname="$1" url=;
    url="$(yq -r '.url' "$fname")" || { 
        echo "Whoops" 1>&2;
        return 1
    };
    echo "Obtaining repository URLs from API endpoint '$url'..." >&2
    yq -i -S -Y '.urls=$urls[] | del(.url)'  "$fname" --slurpfile urls <(get_url_arr "$url")
}

_jsonify_arg() {
    { local -n ref="$1" && declare -p "${!ref}"; } >/dev/null 2>&1 || 
        { printf '"%q"' "$1"; return 0; }
    case "${ref@a}" in
        *a*)        # Array
            printf '['
            for elem in "${ref[@]}"; do
                printf "$(_jsonify_arg "$elem"),"
            done | sed 's/,$//'
            printf ']'
            ;;
        *A*)        # Associative array
            printf '{'
            for key in "${!ref[@]}"; do
                printf '%s:%s,' \
                    "$(_jsonify_arg "$key")" \
                    "$(_jsonify_arg "${ref[$key]}")"
            done | sed 's/,$//'
            printf '}'
            ;;
        *i*)        # Integer
            printf "$ref"
            ;;
        *)          # Anything else gets treated as string
            printf '"%s"' "$ref"
            ;;
    esac
    return $?
}

add_attrs() {
    local -n vals="$1" && shift || return -1
    for f in "$@"; do
        yq -Y -S -i '
    $ARGS.positional[0] as $n |
        $ARGS.positional[1:] as $vs |
        .[$n]+=$vs |
        .history+={(now|todate): ["Added \($vs | length) items to \"\($n)\""]}
        ' "$f" --args "${!vals}" "${vals[@]}"
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
