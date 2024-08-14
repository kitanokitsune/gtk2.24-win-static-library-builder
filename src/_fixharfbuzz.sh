#!/bin/bash
if [ -z "$1" ]; then
    exit
fi

filename="$1/lib/cmake/harfbuzz/harfbuzz-config.cmake"

for i in `seq 10`
do
    bakdir="$1/lib/cmake/harfbuzz/bak$i"
    if [ ! -e "$bakdir" ]; then
        break;
    fi
done


if [ -f "${filename}" ]; then
    FILECONTENT=$( cat ${filename} )
    ### Windows path -> Linux path
    WIN_STYLE_PATH_LIST=$( echo "${FILECONTENT[@]}" | \
                           sed -e 's|"\([a-zA-Z]:/[^"]*\)"|\n\1\n|g' | \
                           grep -E "[a-zA-Z]:/[^/]" | \
                           sort -r | uniq )
    if [ ! -z "${WIN_STYLE_PATH_LIST[@]}" ]; then
        mkdir -p "$bakdir"
        echo 1>&2
        echo "------- ${filename} --------" 1>&2
        echo "${WIN_STYLE_PATH_LIST[@]}" 1>&2
        for p in ${WIN_STYLE_PATH_LIST[@]}
        do
            LINUX_STYLE_PATH=$( cygpath -u "$p" )
            FILECONTENT=$( echo "${FILECONTENT[@]}" | \
                           sed "s|$p|${LINUX_STYLE_PATH}|g" )
        done
        mv "${filename}" "$bakdir"
        echo "${FILECONTENT[@]}" > "${filename}"
        fi
fi


