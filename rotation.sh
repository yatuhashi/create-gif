#!/bin/bash

WORKDIR=`mktemp -d "tmp-image.XXXXXX"`

input=$1
output=$2

convert ${input} -background white -alpha deactivate -flatten ${WORKDIR}/input.png

for i in `seq -f %02g 0 23`; do
      deg=`expr $i \* 15`
        convert -rotate ${deg} ${WORKDIR}/input.png ${WORKDIR}/img-${i}.png
    done

    convert -layers Optimize -loop 0 -delay 4 ${WORKDIR}/img-*.png ${output}
    rm -rf ${WORKDIR}
