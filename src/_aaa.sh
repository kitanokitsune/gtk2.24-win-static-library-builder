#!/bin/bash

if [ -z "$2" ]; then
    exit
fi
if [ ! -e $2 ]; then
    exit
fi

PCFILE=$( cat $2 )

QQQ=$( grep "gcc_win_path" $2 )
if [ -z "${QQQ[@]}" ]; then
    GCC_WIN_PATH=$(cygpath -m `which gcc` | sed 's|/bin/gcc.exe||')
    PPP=$( sed 's|\([^\\]\) \+|\1\n|g' $2 | grep "$GCC_WIN_PATH" | sed 's|/lib[^/]*\.a$||g' | sort | uniq )
    if [ ! -z "${PPP[@]}" ]; then
        echo "---------------------------------------------------------" 1>&2
        echo "$2" 1>&2
        echo "[Insert]" 1>&2
        echo "gcc_win_path=${GCC_WIN_PATH}" 1>&2
        echo "---------------------------------------------------------" 1>&2
        PCFILE=$( echo "${PCFILE[@]}" | sed "1i gcc_win_path=${GCC_WIN_PATH}" )
        for p in ${PPP[@]}
        do
            REALPATH=$(cygpath -m $p | sed "s|${GCC_WIN_PATH}|\$\{gcc_win_path\}|" )
            echo "---------------------------------------------------------" 1>&2
            echo "$2" 1>&2
            echo "[Replace]" 1>&2
            echo "$p" 1>&2
            echo " --> ${REALPATH}" 1>&2
            echo "---------------------------------------------------------" 1>&2
            PCFILE=$( echo "${PCFILE[@]}" | sed "s|$p|${REALPATH}|g" )
        done
    fi
fi

GTK_WIN_PATH=$(cygpath -m $1)
GPP=$( sed 's|\([^\\]\) \+|\1\n|g' $2 | grep "$GTK_WIN_PATH" | sed -e 's|-L\([a-zA-Z]:\)|\1|g' -e 's|-I\([a-zA-Z]:\)|\1|g' | sed 's|/lib[^/]*\.a$||g' | sort | uniq )
if [ ! -z "${GPP[@]}" ]; then
    for p in ${GPP[@]}
    do
        GPPPATH=$(cygpath -m $p | sed "s|${GTK_WIN_PATH}|$1|" )
        echo "---------------------------------------------------------" 1>&2
        echo "$2" 1>&2
        echo "[Replace]" 1>&2
        echo "$p" 1>&2
        echo " --> ${GPPPATH}" 1>&2
        echo "---------------------------------------------------------" 1>&2
        PCFILE=$( echo "${PCFILE[@]}" |  sed "s|$p|${GPPPATH}|g" )
    done
fi

PCFILE=$( echo "${PCFILE[@]}" |  sed "s|\( [^ ]\+\)\1\+|\1|g" )

echo "${PCFILE[@]}"
