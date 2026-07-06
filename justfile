# Default: list recipes
default:
    @just --list

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

# Open the GitHub repository page in the browser
open-repo:
    nu scripts/open-repo.nu

# Open the live GitHub Pages site in the browser
open-site:
    xdg-open https://jconlon.github.io/korea-war/
