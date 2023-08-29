# Cesium Tiles Scraper

Poniższy program ma na celu pobranie zestawu danych potrzebnego do uruchomienia w trybie online biblioteki CesiumJS. 
Oprogramowanie zostało przygotowane i przetestowane na systemie operacyjnym Linux.

## Sposób działania
Program main.py zamienia podane koordynaty w formacie "Bounding Box" (Skrajne koordynaty prostokątu) na współrzędne kafelków w formacie "Slippy" Z/X/Y.
Następnie program wywołuje skrypt download_command.sh przekazując po kolei koordynaty każdego kafelka.

## Pierwsze uruchomienie

Po pobraniu programu, należy uruchomić skrypt ```first_run.sh``` który stworzy odpowiednią skrtukturę katalogów.

Przykładowe uruchomienie programu, które pobierze przybliżenie na obszar Polski oraz Gdańska:
```
download.sh
```
## Sposób użycia

Na stronie https://bboxfinder.com/ należy zaznaczyć interesujący obszar narzędziem "Draw a rectangle".
Skopiować linię "Box" w karcie na dole ekranu.

Wkleić linię w komendzie:
```
./main.py -bb "13.249512,48.763431,24.455566,55.028022" -z 1
```
Parametr "z" definiuje na jakim poziomie przybliżenia mają zostać pobrane kafelki.

Uruchomienie skryptu spowoduje pobranie interesujących nas kafelków.

W celu pobrania całego obszaru na wielu poziomach przybliżenia, należy uruchomić skrypt dla wieru wartości parametru z, np. w pętli. Przykład znajduje się w pliku "download.sh".

### Zmiana dostawcy kafelków

W celu zmiany dostawcy kafelków, należy wprowadzić zmiany w pliku "download_command.sh". Skrypt jest uruchamiany przy każdorazowym pobieraniu danych.
W celu dodania nowego dostawcy należy zdobyć adres URL z właściwymi parametrami autoryzującymi użytkownika. Najłatwiej jest to zrobić następująco:
1. Wejść na stronę WWW dostawcy, np. do środowiska sandbox.
2. Uruchomić narzędzi developerskich przeglądarki (F11)
3. Przejść do karty "Sieć"
4. Znaleźć przykładowego pakietu z rozszerzeniem .jpg/.jpeg lub .terrain
5. Kliknąć prawy przycisk myszy i wybrać opcję "Kopiuj jako cURL"
6. Dodać do pliku download_commmand.sh
7. Zamienić parametry Zoom/X/Y na ${z}/${x}/${y}
8. Dodać przekierowanie do pliku.

### Uruchomienie servera 

W celu uruchomienia przykładowej mapy z użyciem pobranych kafelków, należy uruchomić skrypt:
```
serve.py
```

## TODO

Z nieznanego powodu pliki .terrain posiadają inny format zapisu niż zwykłe "kafelki", które są zapisywane w formacie "Slippy". 
Brak znajomości formatu zapisu plików .terrain nie pozwala na statyczne wygenerowanie listy plików do pobrania (sposób działania obecnego programu).

Bez znajomości sposobu kodowania pozycji kafelków należy zastosować inne rozwiązanie. Stosownym może być zastosowanie biblioteki "Pupeeter" w celu symulacji działania przeglądarki oraz przechwycenia wszystkich pakietów generowanych przez bibliotekę. Pakiety można następnie zapisać do wykorzystania później.
