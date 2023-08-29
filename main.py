#!/usr/bin/env python3
"""
3D tileset offline scraping
http://bboxfinder.com/#48.763431,13.249512,55.028022,24.455566
"""

__author__ = "Marcin Jasiukowicz"
__version__ = "0.1.0"
__license__ = "MIT"

import os
import argparse
import urllib.request
import math

API_KEY="AjyHUGso904JqBrzgYmq"
TILES_BASE_URL="https://api.maptiler.com/tiles/satellite-v2"
TILES_EXTENSION="jpg"
TERRAIN_BASE_URL="https://api.maptiler.com/tiles/terrain-quantized-mesh-v2"
TERRAIN_EXTENSION="terrain"

def deg2num(lat_deg, lon_deg, zoom):
  lat_rad = math.radians(lat_deg)
  n = 1 << zoom
  xtile = int((lon_deg + 180.0) / 360.0 * n)
  ytile = int((1.0 - math.asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n)
  return [xtile, ytile]

def main(args):
    """ Main entry point of the app """
    
    #print(args)
    
    lat_lon = args.boundingbox.split(",")
    zoom=int(args.zoom)
    
    start_tiles=deg2num(float(lat_lon[1]), float(lat_lon[0]), zoom)
    stop_tiles=deg2num(float(lat_lon[3]), float(lat_lon[2]), zoom)

    [x, y]=list(map(list, zip(start_tiles,stop_tiles)))
    x.sort()
    y.sort()

    height=x[1]+1-x[0]
    width=y[1]+1-y[0]
    tiles=abs(height*width)
    print("Downloading %i tiles at %i zoom level (x%s y%s)" % (tiles, zoom, x, y))

    download(x, y, zoom)

def download(x_range, y_range, zoom):
    for x in range(x_range[0], x_range[1]+1):
        for y in range(y_range[0], y_range[1]+1):
            os.system("./download_command.sh %i %i %i &" % (zoom, x, y))

            # PATH="/" + str(zoom) + "/" + str(x) + "/"
            # print(PATH + str(y))

            # if not os.path.exists("assets/tiles"+PATH):
            #     os.makedirs("assets/tiles"+PATH)

            # if not os.path.exists("assets/terrain"+PATH):
            #     os.makedirs("assets/terrain"+PATH)

            #urllib.request.urlretrieve(TILES_BASE_URL + PATH + str(y) + "." +TILES_EXTENSION +"?key="+API_KEY, "assets/tiles"+PATH + str(y) + "." +TILES_EXTENSION)
            #urllib.request.urlretrieve(TERRAIN_BASE_URL + PATH + str(y) + "." +TERRAIN_EXTENSION +"?key="+API_KEY, "assets/terrain"+PATH + str(y) + "." +TERRAIN_EXTENSION)

if __name__ == "__main__":
    """ This is executed when run from the command line """
    parser = argparse.ArgumentParser()

    parser.add_argument("-bb", "--boundingbox", action="store", required=True)
    parser.add_argument("-z", "--zoom", action="store", required=True)

    # Specify output of "--version"
    parser.add_argument(
        "--version",
        action="version",
        version="%(prog)s (version {version})".format(version=__version__))

    args = parser.parse_args()
    main(args)
