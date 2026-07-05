#!/usr/bin/env nu

# Opens the GitHub repository page in the default browser.
# Run from project root: nu scripts/open-repo.nu

let remote = (git remote get-url origin | str trim)

let url = if ($remote | str starts-with "git@github.com:") {
    $"https://github.com/($remote | str replace "git@github.com:" "" | str replace ".git" "")"
} else {
    $remote | str replace ".git" ""
}

xdg-open $url
