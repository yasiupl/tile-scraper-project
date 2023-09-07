# Cesium Tiles Scraper

Poniższy program ma na celu pobranie zestawu danych potrzebnego do uruchomienia w trybie online biblioteki CesiumJS. 
Oprogramowanie zostało przygotowane i przetestowane na systemie operacyjnym Linux.

## Sposób działania
Program opiera się na działaniu skryptu "scraper.py" twórcy: https://github.com/stamen/the-ultimate-tile-stitcher/blob/master/scraper.py
Skrypt został rozwinięty o wsparcie kafelków .terrain.
Program przyjmuje strefenę do pobrania zdefiniowaną w formacie GeoJSON. W ramach poligonu generowana jest lista kafelków do pobrania dla danego poziomu przybliżenia.

## Pierwsze uruchomienie
```
make
make deploy
```

## Sposób użycia

Na stronie https://geojson.io/ należy zaznaczyć interesujący obszar narzędziem "Draw Rectangle".
Wygenerowany tekst JSON należy zapisać w pliku (Save-> GeoJSON) i podać do programu jako parametr `--poly`.
Plik może zawierać wiele niezależnych obszarów, jednak jeżeli chcemy pobrać różne obszary dla różnych poziomów przybliżenia, należy umieścić je w osobnych plikach.

Sposób uzupełnienia komendy:
```
python3 scraper.py --poly masks/world.geojson --zoom $z --url $TILE_URL --out-dir ./assets/tiles --ext jpg
python3 scraper.py --poly masks/world.geojson --zoom $z --url $TERRAIN_URL --out-dir ./assets/terrain --ext terrain
```
Parametr "z" definiuje na jakim poziomie przybliżenia mają zostać pobrane kafelki. Parametr $*_URL definiuje adres URL do kafelków formacie Slippy (kafelki 2D) bądź pliku `layer.json` (kafelki 3D).

Uruchomienie skryptu spowoduje pobranie interesujących nas kafelków.

W celu pobrania całego obszaru na wielu poziomach przybliżenia, należy uruchomić skrypt dla wielu wartości parametru z, np. w pętli. Przykład znajduje się w pliku `scrape.sh`.

### Zmiana dostawcy kafelków

W celu pobrania zestawu kafelków 3D w formacie .terrain, należy podać adres do prawidłowego pliku layer.json dostawcy kafelków. Zostaną z niego obliczone odpowiednie przesunięcia i wygenerowana odpowiednia lista kafelków. Plik zostanie pobrany, umieszczony razem z kafelkami, a adres dostawcy kafelków zostanie automatycznie zmieniony na adres lokalny.

W przypadku autoryzacji innej niż klucz API znajdujący się w adresie, należy dodać odpowiednie ciasteczko lub nagłówek w skrypcie `scraper.py`.

Z racji obciążenia pobieraniem wszystkich kafelków naraz, należy dodać opóźnienia między poszczególnymi pobraniami warstw lub korzystać z wielu kluczy bądź dostawców wspierających duże obciążenia (np. Google).

### Uruchomienie servera 

W celu uruchomienia przykładowej mapy z użyciem pobranych kafelków, należy uruchomić skrypt:
```
serve.py
```