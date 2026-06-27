# Generate KML and sync web map from battle data
build:
    mkdir -p output
    nu scripts/generate-kml.nu
    nu scripts/sync-html.nu

# Open the web map in browser
open:
    xdg-open index.html

# Open the KML in Google Earth
open-kml:
    xdg-open output/korean-war-battles.kml
