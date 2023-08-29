#!/bin/sh
./first_run.sh

## Download area by bbox and zoom level
# Find bbox: http://bboxfinder.com/

echo "Download poland up to zoom level 7"
for z in {0..7}; do
    echo $z
    ./main.py -bb "13.249512,48.763431,24.455566,55.028022" -z $z
done

echo "Download Points of Interest"
for z in {0..15}; do
    # Zakopane
    #./main.py -bb "19.371643,48.973006,20.569153,49.487754" -z $z
    # PG
    #./main.py -bb "18.607578,54.368359,18.628736,54.375058" -z $z
    # Gdańsk
    ./main.py -bb "18.460121,54.309714,18.777008,54.431313" -z $z
done
