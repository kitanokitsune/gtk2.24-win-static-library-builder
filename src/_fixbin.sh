#!/bin/bash
if [ -z "$1" ]; then
    exit
fi

for i in `seq 10`
do
    bakdir="$1/bin/bak$i"
    if [ ! -e "$bakdir" ]; then
        break;
    fi
done
mkdir -p "$bakdir"

if [ -e "$1/bin" ]; then
    FILELIST=`find $1/bin | grep -F -v '.exe'`
    for filename in ${FILELIST[@]}
    do
        if [ -f ${filename} ]; then
            CHK_SHEBANG=`head -n 1 ${filename} | grep -F '#!'`
            if [ ! -z "${CHK_SHEBANG}" ]; then
                FILECONTENT=$( cat ${filename} )
                ### Windows path -> Linux path
                WIN_STYLE_PATH_LIST=$( echo "${FILECONTENT[@]}" | \
                                       sed -e 's|=\([a-zA-Z]:\)| \1|g' \
                                           -e 's|-L\([a-zA-Z]:\)| \1|g' \
                                           -e 's|-I\([a-zA-Z]:\)| \1|g' \
                                           -e "s|'\([a-zA-Z]:/[^']*\)'| \1\n|g" | \
                                       sed 's|\([^\\]\) \+|\1\n|g' | \
                                       grep -E "[a-zA-Z]:/[^/]" | \
                                       sed 's|/lib[^/]*\.a$||g' | \
                                       sort -r | uniq )
                echo "${WIN_STYLE_PATH_LIST[@]}" 1>&2
                if [ ! -z "${WIN_STYLE_PATH_LIST[@]}" ]; then
                    for p in ${WIN_STYLE_PATH_LIST[@]}
                    do
                        LINUX_STYLE_PATH=$( cygpath -u "$p" )
                        FILECONTENT=$( echo "${FILECONTENT[@]}" | \
                                       sed "s|$p|${LINUX_STYLE_PATH}|g" )
                    done
                fi
                #### replace absolute library path with -l<lib> option
                FILECONTENT=$( echo "${FILECONTENT[@]}" | \
                               sed "s| /[^ ]\+/lib/lib\([0-9a-zA-Z_.-]\+\)\.a| -l\1|g" )
                echo 1>&2
                echo "------- ${filename} --------" 1>&2
                mv "${filename}" "$bakdir"
                echo "${FILECONTENT[@]}" > "${filename}"
            fi
        fi
    done
fi


