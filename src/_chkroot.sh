#! /bin/bash

if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
  then
    echo
    echo "*********************************" 1>&2
    echo "* administrative privileges OK! *" 1>&2
    echo "*********************************" 1>&2
    echo
    exit
  else
    echo
    echo "**********************************************" 1>&2
    echo "* ERROR! administrative privileges required! *" 1>&2
    echo "**********************************************" 1>&2
    echo
    exit 1
fi

