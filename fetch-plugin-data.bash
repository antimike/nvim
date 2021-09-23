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
    [raw]="https://raw.githubusercontent.com"
)

declare -A PROPS=(
    [priority]=
    [tags]=
    [config]=
    [comments]=
)

__get_docstring() {
    eval "cat <<-EOF
		`awk -v f="$1" '$1 == f {
		        found = 1; next;
		    }
		    found == 1 {
		        if ($1 == "#")
		            print
		        else 
		            found = 0
		    }' "${BASH_SOURCE[0]}" |
		        sed 's/^[[:space:]]*# //'`
		EOF"
}

_usage() {
    # Display this message and exit
    cat <<-USAGE
		Usage: funcname \${urls[@]}
		Functions: 
		`while read -r line; do
		    printf '  * %s\n' "${line#_}"
		    __get_docstring "$line" | sed 's/^/    | /'
		done < <(grep -o '^_[^_][^[:space:]]\+\(\)' "${BASH_SOURCE[0]}")`
		USAGE
}

_api_query() {
    # Get the raw JSON returned by the Github API for the passed URL
    local stem="${1#${URLS[base]}/}"
    local url="${URLS[api]}/${stem}"
    local -a opts=(
        --silent
        -H
        'Accept: application/vnd.github.preview'
    )
    curl "${opts[@]}" "$url"
    return $?
}

_jq_query() {
    # Get the properties stored in the array FIELDS from the JSON passed via stdin
    # Fields: `printf '\n  - %s' "${FIELDS[@]}"`
    cat - | jq "{`for k in "${!FIELDS[@]}"; do \
        printf '"%s":%s,' "$k" "${FIELDS[$k]}"; done;`}"
    return $?
}

_get_readme() {
    # Get the README.md associated with the passed repository
    # Print to stdout
    local stem="${1#${URLS[base]}/}"
    local url="${URLS[raw]}/${stem}/README.md"
    curl "$url"
    return $?
}

_get_plugin_data() {
    # Pipes output of api_query to jq_query
    _api_query "$1" | _jq_query
    return $?
}

_get_props() {
    # Not implemented
    echo "Not implemented" >&2; exit 2
    for p in "${!PROPS[@]}"; do
        if [ -z "${PROPS[$p]}" ]; then
            PROPS[$p]="$(_user_query "$p")"
        fi
    done
}

main() {
    if grep -q -s "^_${1}()" "${BASH_SOURCE[0]}"; then
        local func="_${1}"; shift
        $func "$@"; exit $?
    else
        _usage; exit -1
    fi
}

main "$@"
