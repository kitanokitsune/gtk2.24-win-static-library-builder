#!/bin/bash

if [ -z "$1" ]; then
    exit
fi

if [ ! -e "$1/lib" ]; then
    exit
fi

LA_FILES=$( find $1/lib -name "*.la"  )
for lafilename in ${LA_FILES[@]}
do
echo 1>&2
echo "------- ${lafilename} --------" 1>&2
sed -i 's|-L=[^ \t]* ||g' $lafilename
done
