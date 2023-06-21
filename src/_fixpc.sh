#!/bin/bash

if [ ! -e "$1/lib/pkgconfig" ]; then
    exit
fi

for i in `seq 10`
do
    bakdir="$1/lib/pkgconfig/bak$i"
    if [ ! -e "$bakdir" ]; then
        break;
    fi
done
mkdir -p "$bakdir"

PC_FILES=$( ls $1/lib/pkgconfig/*.pc  )

for pcfilename in ${PC_FILES[@]}
do

PCFILE=$( cat ${pcfilename} )

### Windows path -> Linux path
WIN_STYLE_PATH_LIST=$( echo "${PCFILE[@]}" | sed -e 's|=\([a-zA-Z]:\)| \1|g' -e 's|-L\([a-zA-Z]:\)| \1|g' -e 's|-I\([a-zA-Z]:\)| \1|g' | sed 's|\([^\\]\) \+|\1\n|g' | grep -E "[a-zA-Z]:/[^/]" | sed 's|/lib[^/]*\.a$||g' | sort -r | uniq )
if [ ! -z "${WIN_STYLE_PATH_LIST[@]}" ]; then
    for p in ${WIN_STYLE_PATH_LIST[@]}
    do
        LINUX_STYLE_PATH=$( cygpath -u "$p" )
        PCFILE=$( echo "${PCFILE[@]}" | sed "s|$p|${LINUX_STYLE_PATH}|g" )
    done
fi

#echo "${PCFILE[@]}"
#exit


#### replace absolute library path with -l<lib> option
PCFILE=$( echo "${PCFILE[@]}" |  sed "s| /[^ ]\+/lib/lib\([0-9a-zA-Z_.-]\+\)\.a| -l\1|g" )


#### exec_prefix=GTKDIR -> exec_prefix=${prefix}
GPP=$( echo "${PCFILE[@]}" | grep "^exec_prefix=" )
if [ ! -z "${GPP}" ]; then
    PCFILE=$( echo "${PCFILE[@]}" |  sed "s|^exec_prefix=$1|exec_prefix=\$\{prefix\}|" )
fi

#### libdir=GTKDIR -> libdir=${prefix}
GPP=$( echo "${PCFILE[@]}" | grep "^libdir=" )
if [ ! -z "${GPP}" ]; then
    PCFILE=$( echo "${PCFILE[@]}" |  sed "s|^libdir=$1|libdir=\$\{prefix\}|" )
fi

#### includedir=GTKDIR -> includedir=${prefix}
GPP=$( echo "${PCFILE[@]}" | grep "^includedir=" )
if [ ! -z "${GPP}" ]; then
    PCFILE=$( echo "${PCFILE[@]}" |  sed "s|^includedir=$1|includedir=\$\{prefix\}|" )
fi




#### GTKDIR/include -> ${includedir}
GPP=$( echo "${PCFILE[@]}" | grep "^includedir=" )
if [ ! -z "${GPP}" ]; then
    PCFILE=$( echo "${PCFILE[@]}" |  sed "s|$1/include|\$\{includedir\}|g" )
fi

#### GTKDIR/lib -> ${libdir}
GPP=$( echo "${PCFILE[@]}" | grep "^libdir=" )
if [ ! -z "${GPP}" ]; then
    PCFILE=$( echo "${PCFILE[@]}" |  sed "s|$1/lib|\$\{libdir\}|g" )
fi





#### remove duplication
PCFILE=$( echo "${PCFILE[@]}" | sed 's|  \+\(-[^ ]\+\)| \1|g' | sed "s|\( -[^ ]\+\)\1\+|\1|g" )

#### prefix=${pcfiledir}/../..
PCFILE=$( echo "${PCFILE[@]}" | sed "s|^prefix=$1|prefix=\$\{pcfiledir\}/../..|" )
PCFILE=$( echo "${PCFILE[@]}" | sed "s|^prefix = $1|prefix = \$\{pcfiledir\}/../..|" )

GPP=$( echo "${PCFILE[@]}" | grep "^prefix=" )
if [ -z "${GPP[@]}" ]; then
    GPP=$( echo "${PCFILE[@]}" | grep "\${prefix}" )
    if [ ! -z "${GPP[@]}" ]; then
        PCFILE=$( echo "${PCFILE[@]}" | sed '1i prefix=\$\{pcfiledir\}/../..' )
    fi
fi

echo 1>&2
echo "------- ${pcfilename} --------" 1>&2
mv "${pcfilename}" "$bakdir"
echo "${PCFILE[@]}" > "${pcfilename}"
#echo "${PCFILE[@]}"
done

