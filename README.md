# Korean War Battle Map (1950–1953)

An interactive geospatial reference for 59 significant engagements of the Korean War, from the KPA's June 1950 invasion through the Panmunjom armistice of July 1953.

## Outputs

### Web Map (`index.html`)
Open directly in any browser — no server required. Features:
- Colored circle markers by phase (red / blue / orange / purple)
- Phase filter buttons to isolate any of the four periods
- Popups with unit designations, casualty figures, outcome, and significance
- Dashed 38th Parallel reference line
- English-language basemap (CartoDB Positron)

### KML (`output/korean-war-battles.kml`)
Open in Google Earth or Google Maps. Battles are organized into four phase folders that can be toggled independently, giving native phase filtering without additional tooling.

## Phases

| # | Period | Dates | Engagements |
|---|--------|-------|-------------|
| 1 | North Korean Invasion | Jun–Sep 1950 | 13 |
| 2 | UN Counter-Offensive | Sep–Oct 1950 | 7 |
| 3 | Chinese Intervention | Oct 1950–Jan 1951 | 17 |
| 4 | Stalemate | Jan 1951–Jul 1953 | 22 |

## Nov–Dec 1950 Coverage

The Chinese intervention phase is documented at sub-engagement granularity, drawing on Roy Appleman's *Disaster in Korea*:

- Chinese 1st Phase Offensive / Battle of Onjong
- ROK II Corps collapse at Tokchon
- Turkish Brigade at Wawon
- Battle of Yudam-ni (5th and 7th Marines)
- Battle of Toktong Pass / Fox Hill (Fox Co., 2/7 Marines)
- Destruction of Task Force Faith (31st RCT, east of Chosin)
- Defense of Hagaru-ri
- Breakout: Hagaru-ri to Koto-ri
- Battle of Funchilin Pass (treadway bridge airdrop)

## Data

All battle data lives in `data/battles.json` — the single source of truth. Each entry includes:

- Coordinates (lat/lon)
- Phase assignment
- UN and opposing force unit designations (regiment/division level)
- Casualty figures (with source discrepancies noted where they exist)
- Outcome and historical significance

## Build

Requires [devbox](https://www.jetify.com/devbox) (provides `just` and `nushell`).

```sh
just build      # regenerate KML and sync web map from battles.json
just open       # open index.html in browser
just open-kml   # open KML in Google Earth
```

## Sources

Primary references for battle data and coordinates:

- Appleman, Roy E. *Disaster in Korea: The Chinese Confront MacArthur*. Texas A&M, 1989.
- Appleman, Roy E. *South to the Naktong, North to the Yalu*. US Army Center of Military History, 1961.
- Blair, Clay. *The Forgotten War: America in Korea 1950–1953*. Times Books, 1987.
- Fehrenbach, T.R. *This Kind of War*. Macmillan, 1963.
- Mossman, Billy C. *Ebb and Flow: November 1950–July 1951*. US Army Center of Military History, 1990.
