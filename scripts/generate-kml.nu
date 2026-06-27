#!/usr/bin/env nu

# Generates output/korean-war-battles.kml from data/battles.json
# Run from project root: nu scripts/generate-kml.nu

def xml-escape [s: string] {
    $s
    | str replace --all '&' '&amp;'
    | str replace --all '<' '&lt;'
    | str replace --all '>' '&gt;'
    | str replace --all '"' '&quot;'
}

def units-html [units: list<string>] {
    $units | each { |u| $"<li>(xml-escape $u)</li>" } | str join ""
}

def placemark [battle: record, style_id: string] {
    let name = xml-escape $battle.name
    let loc  = xml-escape $battle.location
    let desc = xml-escape $battle.description
    let sig  = xml-escape $battle.significance
    let out  = xml-escape $battle.outcome
    let un_cas  = xml-escape $battle.un_casualties
    let kpa_cas = xml-escape $battle.kpa_casualties

    let date_range = if $battle.date_start == $battle.date_end {
        $battle.date_start
    } else {
        $"($battle.date_start) – ($battle.date_end)"
    }

    let un_li  = units-html $battle.un_units
    let kpa_li = units-html $battle.kpa_units

    let html = $"<![CDATA[
<style>
  body{font-family:Arial,sans-serif;font-size:13px;max-width:500px;}
  h2{color:#1a1a2e;margin-bottom:4px;}
  .phase-badge{display:inline-block;padding:2px 8px;border-radius:10px;font-size:11px;font-weight:bold;margin-bottom:8px;}
  table{border-collapse:collapse;width:100%;margin-top:8px;}
  td{padding:4px 8px;vertical-align:top;border-bottom:1px solid #eee;}
  td:first-child{font-weight:bold;white-space:nowrap;color:#555;width:120px;}
  ul{margin:2px 0;padding-left:18px;}
  .outcome{font-weight:bold;}
  .sig{font-style:italic;color:#444;margin-top:8px;border-left:3px solid #ccc;padding-left:8px;}
</style>
<h2>($name)</h2>
<table>
  <tr><td>Date</td><td>($date_range)</td></tr>
  <tr><td>Location</td><td>($loc)</td></tr>
  <tr><td>UN Forces</td><td><ul>($un_li)</ul></td></tr>
  <tr><td>Opposing Forces</td><td><ul>($kpa_li)</ul></td></tr>
  <tr><td>UN Casualties</td><td>($un_cas)</td></tr>
  <tr><td>Enemy Casualties</td><td>($kpa_cas)</td></tr>
  <tr><td>Outcome</td><td class='outcome'>($out)</td></tr>
</table>
<p>($desc)</p>
<p class='sig'>($sig)</p>
]]>"

    $"    <Placemark>
      <name>($name)</name>
      <description>($html)</description>
      <styleUrl>#($style_id)</styleUrl>
      <Point>
        <coordinates>($battle.lon),($battle.lat),0</coordinates>
      </Point>
    </Placemark>"
}

def phase-folder [battles: list<record>, phase_id: int, phase_name: string, style_id: string] {
    let phase_battles = $battles | where phase == $phase_id
    let marks = $phase_battles | each { |b| placemark $b $style_id } | str join "\n"
    $"  <Folder>
    <name>($phase_name)</name>
    <visibility>1</visibility>
($marks)
  </Folder>"
}

let battles = open data/battles.json

let styles = '  <Style id="phase1">
    <IconStyle>
      <color>ff0000ff</color>
      <scale>1.1</scale>
      <Icon><href>http://maps.google.com/mapfiles/kml/paddle/red-circle.png</href></Icon>
    </IconStyle>
    <BalloonStyle>
      <text>$[description]</text>
    </BalloonStyle>
  </Style>
  <Style id="phase2">
    <IconStyle>
      <color>ffff0000</color>
      <scale>1.1</scale>
      <Icon><href>http://maps.google.com/mapfiles/kml/paddle/blu-circle.png</href></Icon>
    </IconStyle>
    <BalloonStyle>
      <text>$[description]</text>
    </BalloonStyle>
  </Style>
  <Style id="phase3">
    <IconStyle>
      <color>ff00a5ff</color>
      <scale>1.1</scale>
      <Icon><href>http://maps.google.com/mapfiles/kml/paddle/ylw-circle.png</href></Icon>
    </IconStyle>
    <BalloonStyle>
      <text>$[description]</text>
    </BalloonStyle>
  </Style>
  <Style id="phase4">
    <IconStyle>
      <color>ff800080</color>
      <scale>1.1</scale>
      <Icon><href>http://maps.google.com/mapfiles/kml/paddle/purple-circle.png</href></Icon>
    </IconStyle>
    <BalloonStyle>
      <text>$[description]</text>
    </BalloonStyle>
  </Style>'

let p1_name = "Phase 1: North Korean Invasion (Jun-Sep 1950)"
let p2_name = "Phase 2: UN Counter-Offensive (Sep-Oct 1950)"
let p3_name = "Phase 3: Chinese Intervention (Oct 1950-Jan 1951)"
let p4_name = "Phase 4: Stalemate (Jan 1951-Jul 1953)"
let doc_name = "Korean War Battle Map (1950-1953)"
let doc_desc = "50 significant engagements of the Korean War, grouped by phase. Toggle phase folders to filter by period."

let folder1 = phase-folder $battles 1 $p1_name "phase1"
let folder2 = phase-folder $battles 2 $p2_name "phase2"
let folder3 = phase-folder $battles 3 $p3_name "phase3"
let folder4 = phase-folder $battles 4 $p4_name "phase4"

let count = ($battles | length)

let kml = $"<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<kml xmlns=\"http://www.opengis.net/kml/2.2\">
<Document>
  <name>($doc_name)</name>
  <description>($doc_desc)</description>
($styles)
($folder1)
($folder2)
($folder3)
($folder4)
</Document>
</kml>"

mkdir output
$kml | save --force output/korean-war-battles.kml
print $"KML written to output/korean-war-battles.kml \(($count) battles\)"
