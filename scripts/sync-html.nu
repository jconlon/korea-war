#!/usr/bin/env nu

# Updates the BATTLES array in index.html from data/battles.json.
# Run from project root: nu scripts/sync-html.nu

let battles = open data/battles.json
let html_lines = open --raw index.html | lines

let start_idx = (
    $html_lines
    | enumerate
    | where { |l| $l.item | str starts-with "const BATTLES = [" }
    | first
    | get index
)

let end_idx = (
    $html_lines
    | enumerate
    | where { |l| $l.index > $start_idx and $l.item == "];" }
    | first
    | get index
)

let count = ($battles | length)
let last_idx = $count - 1

let battle_lines = $battles | enumerate | each { |e|
    let suffix = if $e.index < $last_idx { "," } else { "" }
    "  " + ($e.item | to json --raw) + $suffix
}

let before_lines = $html_lines | take $start_idx
let after_lines  = $html_lines | skip ($end_idx + 1)

let new_content = (
    $before_lines
    | append ["const BATTLES = ["]
    | append $battle_lines
    | append ["];"]
    | append $after_lines
    | str join "\n"
) + "\n"

$new_content | save --force index.html
print $"index.html BATTLES array updated \(($count) battles\)"
