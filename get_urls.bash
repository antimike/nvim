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

add_attrs() {
    local attr="$1" && shift
    local -n vals="$1" && shift || return -1
    for f in "$@"; do
        yq -Y -S -i '
    $ARGS.positional[0] as $n |
    $ARGS.positional[1:] as $vs |
    .[$n]+=($vs | map({($n):.,"timestamp":(now|todate)}))
        ' "$f" --args "${vals[@]}"
    done
}
