#!/bin/bash
# Uses the Github API to fetch repository metadata for a list of vim plugins,
# writing the results to a designated logfile / queue (default: stdout)

declare -A FIELDS=(
    # jq expressions to extract desired information from JSON returned by Github
    # API
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
    # User-provided information
    [priority]=
    [tags]=
    [config]=
    [comments]=
)

__get_docstring() {
    # Prints commented lines found directly underneath a function definition
    # (inspired by Python's docstring)
    # Before printing, the text is trimmed to remove leading whitespace and #,
    # then \`eval\`d to allow the use of Bash variables and command
    # substitutions
    # Params:
    #   \$1 --> Name of function to find docstring for
    # NOTE: Since the docstring contents are \`eval\`d, shell metacharacters
    # must be escaped in order to be printed literally
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
		        sed 's/^[[:space:]]*# \?//'`
		EOF"
}

_usage() {
    # Display this message and exit
    cat <<-USAGE
		Usage: funcname url
		Functions: 
		`while read -r line; do
		    printf '  * %s\n' "${line#_}"
		    __get_docstring "$line" | sed 's/^/    | /'
		done < <(grep -o '^_[^_][^[:space:]]\+\(\)' "${BASH_SOURCE[0]}")`
		USAGE
}

_to_tsv() {
    # Convert a JSON object to TSV.  Sorts by keys before dumping TSV data.
    # Input (stdin): A JSON object
    # Output (stdout): A single tab-delimited line containing the **values**
    # found in the input, printed in the sort-order of the corresponding keys
    cat - | jq -S '.' | jq -r 'map_values(@text) | [.[]] | @tsv'
}

_api_query() {
    # Get the raw JSON returned by the Github API for the passed URL
    # Input:
    #   \$1 --> URL of github repo.  Can be either a full Github URL or
    #   abbreviated (e.g., "antimike/dotfiles.git")
    # Output (stdout): Full JSON dump of the repository data returned by the
    # Github API, formatted by \`jq\`
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
    # Input (stdin): A JSON object containing the keys found in FIELDS (see
    # below)
    # Output (stdout): JSON object containing only the keys found in FIELDS and
    # the corresponding values
    # Fields: `printf '\n  - %s' "${!FIELDS[@]}"`
    cat - | jq -S "{`for k in "${!FIELDS[@]}"; do \
        printf '"%s":%s,' "$k" "${FIELDS[$k]}"; done;`}"
    return $?
}

_get_readme() {
    # Get the README.md associated with the passed repository
    # Input:
    #   \$1 --> Repository URL
    # Output (stdout): Raw text of README.md for the passed repository
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
    # Checks if first argument is the name of a function defined in this script
    # If it is, the function is executed with the rest of the params as
    # arguments
    if grep -q -s "^_${1}()" "${BASH_SOURCE[0]}"; then
        local func="_${1}"; shift
        $func "$@"; exit $?
    else
        _usage; exit -1
    fi
}

main "$@"
