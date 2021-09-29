#!/bin/bash
get_urls () 
{ 
    local fname="$1" url=;
    url="$(yq -r '.url' "$fname")" || { 
        echo "Whoops" 1>&2;
        return 1
    };
    yq -i -S -Y '.urls=$urls | del(.url)' --slurpfile urls <(get_url_arr "$url") "$fname"
}
