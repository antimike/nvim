#!/bin/bash
# Uses the Github API to fetch repository metadata for a list of vim plugins,
# writing the results to a designated logfile / queue (default: stdout)

set -o pipefail

declare -A FIELDS=(
    # jq expressions to extract desired information from JSON returned by Github
    # API
    [name]=".name"
    [owner]=".owner.login"
    [description]=".description"
    [url]=".url"
    [stars]=".stargazers_count"
    [archived]=".archived"
    [default_branch]=".default_branch"
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

declare -a README_EXTS=(
    md
    markdown
    rst
)

declare MASTER_TSV="`pwd`/nvim-plugins.tsv"
export EXT=

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

_functions() {
    # Lists functions defined in this script
    # If any arguments are passed, they are treated as function names to search
    # for and are re-echoed if found
    local -i ret=0
    while true; do
        local fn_re="${1:-[a-zA-Z_]\+}()"  # Regex to search for
        grep -o "^_${fn_re}" "${BASH_SOURCE[0]}" | 
            sed 's/^_//' |
            grep -v '^_' || let ret+=1
        shift && [ $# -gt 0 ] || break
    done
    return $ret
}

_usage() {
    # Display helptext for passed functions
    # If no arguments are provided, display helptext for all functions
    # Input:
    #   \$1 --> Name of function to print helptext.  A leading underscore is
    #   added to the passed function name.
    # Output (stdout): Helptext ("docstring") associated to the passed function
    # name.
    while read -r line; do
        printf '* %s\n' "$line"
        printf '  %s\n' "$(tr [[:graph:]] [-*] <<<"$line")"
        __get_docstring "_${line}" | sed 's/^/    | /'
    done < <(_functions "$@")
    return $?
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
    # Get the README.{ext} associated with the passed repository, where 'ext' is
    # one of the following possible extensions: `printf '\n  - %s' \
    # "${README_EXTS[@]}"`
    # Input:
    #   \$1 --> Repository URL
    #   \$2 --> Branch (defaults to 'master')
    # Output (stdout): Raw text of README.{ext} for the passed repository
    # Actions: Stores the found extension in the variable EXT 
    # Options:
    #   -d      Directory to write retrieved README file to
    local -a opts=(
        --silent
    )

    local dir=
    while getopts ':d:' opt; do
        case "$opt" in
            d) dir="$OPTARG" ;;
            *) _usage get_readme >&2; exit 4 ;;
        esac
    done
    shift $(( OPTIND - 1 )); OPTIND=1

    local stem="${1#${URLS[base]}/}" branch="${2:-master}" fname= dest=
    for ext in "${README_EXTS[@]}"; do
        fname="README.${ext}" dest="${dir}/${fname}"
        mkdir -p "$dir" 2>/dev/null || fname="/dev/null"
        if [ -e "$fname" ]; then
            read -n 1 -s -p "File '$fname' already exists.  Overwrite? "
            case "$REPLY" in
                y|Y) ;;
                *) echo "Aborted" >&2; return 7 ;;
            esac
        fi

        { curl "${opts[@]}" "${URLS[raw]}/${stem}/${branch}/${fname}" | 
            tee "$dest"; } && export EXT="$ext"
    done
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

_process_urls() (
    # Processes a list of URLs of vim/nvim plugin repos on Github
    # Specifically, the following actions are performed:
    #   - A directory in \`pwd\` is created for each plugin
    #   - The README.md for each plugin is downloaded and stored in its
    #   directory
    #   - The JSON data from \`get_plugin_data\` is stored as a YAML frontmatter
    #   header to the README, and is also added to a "master" TSV file
    #   containing summaries of all the plugins
    # Input (stdin and params): A list of URLs of Github repos
    # Output (stdout): None
    # Options:
    #   -l      Logfile (master TSV).  Defaults to "\`pwd\`/nvim-plugins.tsv".
    while getopts ":l:" opt; do
        case "$opt" in
            l) MASTER_TSV="$OPTARG" ;;
            *) _usage process_urls >&2; exit 5 ;;
        esac
    done
    shift $(( OPTIND - 1 )); OPTIND=1

    local -A failed=( )
    local json= dir=
    while read -r url; do
        # Text processing
        json="$(_get_plugin_data "$url")"
        dir="$(jq '.name' <<<"$json")"
        yaml="$(yq -Y '.' <<<"$json")"

        # Make plugin directory
        until [ $? -ne 0 ] || mkdir "$dir"; do
            echo "Failed to make plugin directory '${dir}'."
            read -r -p "
Enter another name to attempt directory creation for this plugin: " dir
        done

        # Write README to plugin dir with YAML header
        readme="${dir}/README.${EXT}"
        printf '%s\n' "---" "$yaml" "---" >"$readme"
        _get_readme "$url" >>"$readme"

        # Append plugin summary to master TSV
        printf '%s\n' "$(_to_tsv <<<"$json")" >>"$MASTER_TSV"
    done < <(cat - <(printf '%s\n' "$@"))
    if [ ${#failed[@]} -ne 0 ]; then
        echo "Failed:"
        printf '  %s	%s\n' "${failed[@]@K}"
    fi >&2
    return ${#failed[@]}
)

__fetch_main() {
    # Checks if first argument is the name of a function defined in this script
    # If it is, the function is executed with the rest of the params as
    # arguments
    if grep -q -s "^_${1}()" "${BASH_SOURCE[0]}"; then
        local func="_${1}"; shift
        $func "$@"; exit $?
    else
        _usage "$func"; exit -1
    fi
}

__fetch_main "$@"
