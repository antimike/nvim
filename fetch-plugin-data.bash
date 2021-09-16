#!/bin/bash
# Uses the Github API to fetch repository metadata for a list of vim plugins,
# writing the results to a designated logfile / queue (default: stdout)

declare -A FIELDS=(
    [name]=".name"
    [owner]=".owner.login"
    [description]=".description"
    [url]=".url"
    [stars]=".stargazers_count"
    [archived]=".archived"
)

declare -A URLS=(
    [base]="https://github.com"
    [api]="https://api.github.com/repos"
)

declare -A PROPS=(
    [priority]=
    [tags]=
    [config]=
    [comments]=
    [timestamps]=
)

_json_callback() {
    :
}


_print_markup_recursive() {
    # Generic function for recursively dumping a Bash variable to a markup
    # format specified by a user-provided callback
    # The callback should take two arguments:
    #   (1) A reference to a Bash variable;
    #   (2) A reference to a callback for recursive printing.
    local -A opts=(
        [a:]="format-array:"
        [A:]="format-assoc-array:"
        [v:]="format-value:"
    )
    parsed="$(getopt -o "$(printf '%s' "${!opts[@]}")" \
        --long "$(printf '%s,' "${opts[@]}" | sed 's/,$//')")"
    eval set -- "$parsed"
    local -i s=1       # How many params to shift
    while true; do case "$1" in
        --*) 
            for opt in "${!opts[@]}"; do
                case "${opts[$opt]}" in
                    ${1#--}:?) let s=2; opts[$opt]="$2" ;;
                    ${1#--}) let s=1 opts[$opt]+=1 ;;
                esac
            done
            ;;
        -*)
            case "$1" in
                *:?) let s=2; opts[$1]="$2" ;;
                *) let s=1 opts[$1]+=1 ;;
            esac
            ;;
        --)
            shift; break
            ;;
    esac; shift $s; done

    local -n ref="$1" kind= parsed=

    kind="$(declare -p "${!ref}" 2>/dev/null | cut -f2)" ||
        { echo "Variable '${!ref}' not found" >&2; return 1; }
    case "$kind" in
        -*a*)
            printf '['
            for elem in "${ref[@]}"; do
                printf '%s%s%s,' "$delim" "$elem" "$delim"
            done | sed 's/,$//'
            printf ']'
            ;;
        -*A*)
            printf '{'
            for key in "${!ref[@]}"; do
                printf '%s%s%s:%s%s%s,' "$kdelim" "$key" "$kdelim" \
                    "$delim" "${ref[$key]}" "$delim"
            done
            printf '}'
            ;;
    esac
}

_jsonify() {
    # Prints a Bash associative array as a JSON object (for passing to JQ, e.g.)
    # Options:
    #   -q      Quote values as well as keys (default is nonquoted values)
    local delim='' kdelim='"'
    local -A opts=( )
    case "$1" in 
        -*) opts[$1]=1; shift ;;
    esac
    if [ -n "${opts[-q]}" ]; then
        delim="$kdelim"
    fi
    local -n ref="$1"

    local kind="$(declare -p "${!ref}" >/dev/null 2>&1 |
        cut -f2)"
    case "$kind" in
        -*a*)       # Regular array
            {
                for item in "${ref[@]}"; do
                    printf "${delim}%s${delim}," "$(_jsonify
            printf '['
            printf "${delim}%s${delim}," "${ref[@]}" |
                sed 's/,$//'
            printf ']'
            ;;
    for k in "${!ref[@]}"; do
        local val="${ref[$k]}"
        if declare -p "$val" >/dev/null 2>&1; then
            val="$(_jsonify "$val")"
        fi
        printf "${kdelim}%s${kdelim}:${delim}%s${delim}," "$k" "${ref[$k]}"
    done
}

_api_query() {
    local stem="${1#${URLS[base]}/}"
    local url="${URLS[api]}/${stem}"
    local -a opts=(
        --silent
        -H
        'Accept: application/vnd.github.preview'
    )
    curl "${opts[@]}" "$url"
}

_jq_query() {
    cat - | jq "{`for k in "${!FIELDS[@]}"; do \
        printf '"%s":%s,' "$k" "${FIELDS[$k]}"; done;`}"
}

_get_props() {

    for p in "${!PROPS[@]}"; do
        if [ -z "${PROPS[$p]}" ]; then
            PROPS[$p]="$(_user_query "$p")"

main() {
    while [ $# -gt 0 ]; do
        _api_query "$1" | _jq_query
        shift
    done
}

main "$@"
