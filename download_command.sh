#!/bin/sh

z=$1
x=$2
y=$3

echo Downloading ${z}/${x}/${y}

mkdir -p assets/tiles/${z}/${x}

curl -s "https://api.maptiler.com/tiles/satellite-v2/${z}/${x}/${y}.jpg?key=AjyHUGso904JqBrzgYmq" -o assets/tiles/${z}/${x}/${y}.jpg

mkdir -p assets/terrain/${z-1}/${x}

curl -s "https://api.maptiler.com/tiles/terrain-quantized-mesh-v2/${z}/${x}/${y}.terrain?key=AjyHUGso904JqBrzgYmq" -o assets/terrain/${z}/${x}/${y}.terrain

## How-to:
# Go to Chrome/Firefox Web-tools (F11), go to Network tab, right click on any .jpg / .terrain file. Select "Copy as cURL".
# Paste here and replace tile coordinates with ${z}/${x}/${y}
 
#curl "https://assets.ion.cesium.com/asset_depot/1/CesiumWorldTerrain/v1.2/${z}/${x}/${y}.terrain?extensions=octvertexnormals-watermask-metadata&v=1.2.0" --compressed -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0' -H 'Accept: application/vnd.quantized-mesh,application/octet-stream;q=0.9,*/*;q=0.01' -H 'Accept-Language: en,pl;q=0.5' -H 'Accept-Encoding: gzip, deflate, br' -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI5NTU1NjM3OS1kNGE2LTQ4MDUtYjVlMi1hNmViYjUyYjA3MDAiLCJpZCI6MjU5LCJhc3NldHMiOnsiMSI6eyJ0eXBlIjoiVEVSUkFJTiIsImV4dGVuc2lvbnMiOlt0cnVlLHRydWUsdHJ1ZV0sInB1bGxBcGFydFRlcnJhaW4iOmZhbHNlfX0sInNyYyI6Ijc4NmQwNDM5LTdkYmMtNDNlZS1iOWZjLThmYzljZTA3M2EyZiIsImlhdCI6MTY5MzE1OTg0MiwiZXhwIjoxNjkzMTYzNDQyfQ.xI1Nc-U0wGQR7Ijxxan8jhZxG8-Lnt4-javOH5f9ojA' -H 'X-Cesium-Client: CesiumJS' -H 'X-Cesium-Client-Version: 1.108' -H 'Origin: https://sandcastle.cesium.com' -H 'Connection: keep-alive' -H 'Referer: https://sandcastle.cesium.com/' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-site' > assets/terrain/${z}/${x}/${y}.terrain
