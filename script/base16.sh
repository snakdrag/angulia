#!/bin/bash

JSON_PATH="$HOME/.config/quickshell/angulia/settings/colors/colors.json"
BASE16_PATH="$HOME/.config/angulia/base16.conf"

if [ ! -f "$JSON_PATH" ]; then
    exit 1
fi

BG=$(jq -r '.base16.base00.default.color' "$JSON_PATH")

BASE00=$(jq -r '.base16.base00.default.color' "$JSON_PATH")
BASE01=$(jq -r '.base16.base01.default.color' "$JSON_PATH")
BASE02=$(jq -r '.base16.base02.default.color' "$JSON_PATH")
BASE03=$(jq -r '.base16.base03.default.color' "$JSON_PATH")
BASE04=$(jq -r '.base16.base04.default.color' "$JSON_PATH")
BASE05=$(jq -r '.base16.base05.default.color' "$JSON_PATH")
BASE06=$(jq -r '.base16.base06.default.color' "$JSON_PATH")
BASE07=$(jq -r '.base16.base07.default.color' "$JSON_PATH")
BASE08=$(jq -r '.base16.base08.default.color' "$JSON_PATH")
BASE09=$(jq -r '.base16.base09.default.color' "$JSON_PATH")
BASE0A=$(jq -r '.base16.base0a.default.color' "$JSON_PATH")
BASE0B=$(jq -r '.base16.base0b.default.color' "$JSON_PATH")
BASE0C=$(jq -r '.base16.base0c.default.color' "$JSON_PATH")
BASE0D=$(jq -r '.base16.base0d.default.color' "$JSON_PATH")
BASE0E=$(jq -r '.base16.base0e.default.color' "$JSON_PATH")
BASE0F=$(jq -r '.base16.base0f.default.color' "$JSON_PATH")

mkdir -p "$(dirname "$BASE16_PATH")"
cat << EOF > "$BASE16_PATH"

BASE00=$BASE00
BASE01=$BASE01
BASE02=$BASE02
BASE03=$BASE03
BASE04=$BASE04
BASE05=$BASE05
BASE06=$BASE06
BASE07=$BASE07
BASE08=$BASE08
BASE09=$BASE09
BASE0A=$BASE0A
BASE0B=$BASE0B
BASE0C=$BASE0C
BASE0D=$BASE0D
BASE0E=$BASE0E
BASE0F=$BASE0F

color0  $BASE00
color1  $BASE01
color2  $BASE02
color3  $BASE03
color4  $BASE04
color5  $BASE05
color6  $BASE06
color7  $BASE07

color8  $BASE08
color9  $BASE09
color10 $BASE0A
color11 $BASE0B
color12 $BASE0C
color13 $BASE0D
color14 $BASE0E
color15 $BASE0F

EOF
