#!/bin/bash

WORKDIR=`mktemp -d "tmp-image.XXXXXX"`

input=$1
output=$2

convert ${input} -background white -alpha deactivate -flatten ${WORKDIR}/input.png
convert -size 110x110 xc:none ${WORKDIR}/tmp.png
convert ${WORKDIR}/tmp.png -background white -alpha deactivate -flatten ${WORKDIR}/tmp.png

for i in `seq -f %02g 1 5`; do
    deg=`expr  $i \* 12`
        convert -geometry ${deg}x60! ${WORKDIR}/input.png ${WORKDIR}/img-${i}.png

        composite -gravity center -dissolve 100%x1% ${WORKDIR}/img-${i}.png ${WORKDIR}/tmp.png ${WORKDIR}/img-${i}.png
    done

for i in `seq -f %02g 6 10`; do
    deg=`expr 132 - $i \* 12 `
        convert -geometry ${deg}x60! ${WORKDIR}/input.png ${WORKDIR}/img-${i}.png

        composite -gravity center -dissolve 100%x1% ${WORKDIR}/img-${i}.png ${WORKDIR}/tmp.png ${WORKDIR}/img-${i}.png
    done

convert -flop ${input} ${WORKDIR}/inputg.png
convert ${WORKDIR}/inputg.png -background white -alpha deactivate -flatten ${WORKDIR}/inputg.png

for i in `seq -f %02g 11 15`; do
    deg=`expr $i \* 12 - 120`
        convert -geometry ${deg}x60! ${WORKDIR}/inputg.png ${WORKDIR}/img-${i}.png

        composite -gravity center -dissolve 100%x1% ${WORKDIR}/img-${i}.png ${WORKDIR}/tmp.png ${WORKDIR}/img-${i}.png
    done

for i in `seq -f %02g 15 20`; do
    deg=`expr 252 - $i \* 12`
        convert -geometry ${deg}x60! ${WORKDIR}/inputg.png ${WORKDIR}/img-${i}.png

        composite -gravity center -dissolve 100%x1% ${WORKDIR}/img-${i}.png ${WORKDIR}/tmp.png ${WORKDIR}/img-${i}.png
    done

    convert -layers Optimize -loop 0 -delay 8 ${WORKDIR}/img-*.png ${output}
    rm -rf ${WORKDIR}
