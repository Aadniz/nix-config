#!/usr/bin/env bash

ICON_COLOR="#FF0000"

if [[ $1 == "--color" ]] && [[ -n $2 ]]; then
    ICON_COLOR=$2
fi

COPY_COLOR="${SECONDARY_COLOR:-#FF00FF}"

DAY=$(date '+%u')
KANJI="月"

case $DAY in
    1) KANJI="月" ;;
    2) KANJI="火" ;;
    3) KANJI="水" ;;
    4) KANJI="木" ;;
    5) KANJI="金" ;;
    6) KANJI="土" ;;
    7) KANJI="日" ;;
    *) KANJI="なにかへん" ;;
esac

epoch=$(date '+%s')
epoch_human_readable=$(echo "$epoch" | sed 's/./&-/3; s/./&-/7')

# Copy epoch to clipboard
if [[ $BLOCK_BUTTON && $BLOCK_BUTTON -eq 2 ]]; then
	echo "<span color=\"$COPY_COLOR\">$KANJI $epoch</span>"
	echo -n $epoch | wl-copy
else
	date "+%Y-%m-%d <span color=\"$ICON_COLOR\">$KANJI</span> %H:%M:%S"
fi

date '+%Y-%m-%d'
echo "$color15"
