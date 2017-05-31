#!/bin/bash

WORKDIR=`mktemp -d "tmp-image.XXXXXX"`

input=$1
output=$2

convert ${input} -background white -alpha deactivate -flatten ${WORKDIR}/input.png
convert -size 128x128 xc:none ${WORKDIR}/tmp.png
convert ${WORKDIR}/tmp.png -background white -alpha deactivate -flatten ${WORKDIR}/tmp.png

for i in `seq -f %02g 1 10`; do
      deg=`expr $i \* 12`
        convert -resize ${deg}x${deg} ${WORKDIR}/input.png ${WORKDIR}/img-${i}.png
        composite -gravity center -dissolve 100%x1% ${WORKDIR}/img-${i}.png ${WORKDIR}/tmp.png ${WORKDIR}/img-${i}.png
    done

    convert -layers Optimize -loop 0 -delay 6 ${WORKDIR}/img-*.png ${output}
    rm -rf ${WORKDIR}
