#!/bin/sh

## Download area by bbox and zoom level
# Find bbox: https://geojson.io/

#KEY=k2hhflbTWxTRtGJddsbx
#KEY=AjyHUGso904JqBrzgYmq 
KEY=RI00UfUzfjCFmHliNnTi 

TERRAIN_URL=https://api.maptiler.com/tiles/terrain-quantized-mesh-v2/layer.json?key=$KEY
# https://sandcastle.cesium.com/?src=Terrain.html
#TERRAIN_URL="https://assets.ion.cesium.com/asset_depot/1/CesiumWorldTerrain/v1.2/{z}/{x}/{y}.terrain"

TILE_URL="https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}"
#TILE_URL=https://api.maptiler.com/tiles/satellite-v2/${z}/${x}/${y}.jpg?key=$KEY

## Start Downloading

scraper_script=./tile-scraper/scraper.py

# mkdir -p assets/tiles
# mkdir -p assets/terrain

echo "Download the world up to zoom level 4"
for z in {0..4}; do
    echo $z
    python3 $scraper_script --poly masks/world.geojson --zoom $z --url $TILE_URL --out-dir assets/tiles --ext jpg
    python3 $scraper_script --poly masks/world.geojson --zoom $z --url $TERRAIN_URL --out-dir assets/terrain --ext terrain
done

echo "Download Poland up to zoom level 9"
for z in {5..9}; do
    echo $z
    python3 $scraper_script --poly masks/poland.geojson --zoom $z --url $TILE_URL --out-dir assets/tiles --ext jpg
    python3 $scraper_script --poly masks/poland.geojson --zoom $z --url $TERRAIN_URL --out-dir assets/terrain --ext terrain
done

echo "Download Gdańsk up to zoom level 15"
for z in {10..15}; do
    echo $z
    python3 $scraper_script --poly masks/gdansk.geojson --zoom $z --url $TILE_URL --out-dir assets/tiles --ext jpg
    python3 $scraper_script --poly masks/gdansk.geojson --zoom $z --url $TERRAIN_URL --out-dir assets/terrain --ext terrain
done

echo "Download Tatry up to zoom level 15"
for z in {10..15}; do
    echo $z
    python3 $scraper_script --poly masks/tatry.geojson --zoom $z --url $TILE_URL --out-dir assets/tiles --ext jpg
    python3 $scraper_script --poly masks/tatry.geojson --zoom $z --url $TERRAIN_URL --out-dir assets/terrain --ext terrain
done
