#!/bin/sh

mkdir -p assets/tiles/
mkdir -p assets/terrain/
cp layer.json assets/terrain

## World
echo "Download world basemap"
z=0
for x in {0..1}; do
    for y in {0..1}; do
        ./download_command.sh $z $x $y
    done
done 