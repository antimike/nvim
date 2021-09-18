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
        fi
    done
}

main() {
    while [ $# -gt 0 ]; do
        _api_query "$1" | _jq_query
        shift
    done
}

main "$@"
