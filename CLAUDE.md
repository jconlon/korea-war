# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Environment

Dependencies are managed via **devbox**. The shell is already initialized — all packages are on PATH. Node.js is available via NVM (loaded in the devbox init hook).

Installed packages: `just`, `nushell`, `github-cli`.

## Commands

No justfile exists yet. When adding reusable commands, write them as **nushell scripts** and wire them up as just tasks.

## Claude Agent Sessions

The devbox scripts define named Claude Code sessions for this project:

```
devbox run agent        # Resume the named 'korea-war' session
devbox run agent-new    # Start a fresh session
devbox run agent-plan   # Opus model in plan-only permission mode
devbox run agent-small  # Haiku model
devbox run agent-big    # Opus model
```

## Project Status

Greenfield — no application code exists yet. Architecture and tooling choices are yet to be made.

## Domain Context

### Korean War History

The user is an advanced historian of the Korean War. Do not define basic terms (38th parallel, KPA, ROK, NKPA, CPVF), explain unit hierarchy, or summarize well-known events. Engage at a specialist level:

- **Command structure**: Eighth Army (Walker, then Ridgway, then Van Fleet), X Corps (Almond), I Corps, IX Corps, and their subordinate divisions. Know the difference between EUSAK operational control and MacArthur's FECOM authority.
- **Chronology**: The user works fluently across all phases — Pusan Perimeter (June–September 1950), Inchon/Seoul/pursuit north (September–October 1950), Chinese intervention and the November/December catastrophe (1st and 2nd Phase Offensives, Chosin Reservoir, withdrawal from North Korea), the see-saw of 1951 (Thunderbolt, Roundup, Killer, Ripper, the April and May CCF offensives), and the static war through armistice (July 1953).
- **Political/strategic layer**: NSC-68, the limited-war concept, MacArthur's relief (April 11, 1951), Ridgway's rehabilitation of Eighth Army morale and doctrine, the armistice negotiations at Kaesong then Panmunjom (beginning July 1951), the POW repatriation impasse, and Eisenhower's nuclear signaling.
- **Unit designations**: Regiment/division level and above are the primary granularity for this project. Examples the user uses without gloss: 1st Marine Division, 7th Infantry Division, 2nd Infantry Division, 187th Airborne RCT, 1st Cavalry Division, ROK 1st Division, British 29th Brigade, Turkish Brigade, 3rd Battalion 7th Marines, etc.

When discussing battles or positions, use standard military map convention (grid references, compass bearings, phase lines) without explaining what they mean.

### KML Expertise

The user knows the KML 2.2 spec thoroughly. Do not explain folder hierarchy, Placemark schema, Style/StyleMap, NetworkLink, GroundOverlay, CDATA blocks, or ExtendedData. Skip structural preamble and address project-specific decisions directly:

- Which features belong in which folder layer
- When to use NetworkLink vs. inline data for performance
- Style inheritance decisions and when a shared StyleMap is worth the indirection
- Coordinate precision and altitude mode choices appropriate to the data
- Schema design for ExtendedData (battle metadata: date range, phase, units engaged, casualty figures, source citations)

### Data Accuracy Expectations

Historical accuracy is a hard requirement, not a best-effort goal:

- Use correct unit designations (including numerical designation, branch, and type — e.g., "23rd Infantry Regiment, 2nd Infantry Division" not "23rd Regiment").
- Coordinates must be historically defensible. Cross-check against period maps, after-action reports, or established secondary sources (Appleman, Blair, Fehrenbach, Mossman) when placing battle markers.
- **Key source for November 1950**: *Disaster in Korea* (Roy Appleman) covers MacArthur's drive to the Yalu and the Chinese 1st and 2nd Phase Offensives in detail. Reference it for any engagements in that window — unit positions, axis of advance, and the collapse of the Ch'ongch'on line.
- Casualty figures often vary across the historiography. When figures conflict significantly (Chosin Reservoir is the canonical example — UN vs. CPVF losses are disputed across a wide range), note the discrepancy and cite the competing estimates by source rather than picking one silently.
- Do not smooth over gaps in the record. If a unit's position on a given date is uncertain, say so.
