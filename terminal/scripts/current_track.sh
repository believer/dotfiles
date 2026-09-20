#!/bin/bash

if ! command -v media-control &> /dev/null; then
	echo "♫ media-control not found"
	exit 1
fi

RAW=$(media-control get --now 2>/dev/null)

if [ -z "$RAW" ] || [ "$RAW" == "null" ]; then
	echo "♫ Nothing playing"
	exit 0
fi

TITLE=$(echo $RAW | jq -r '.title')
ARTIST=$(echo $RAW | jq -r '.artist')
DURATION=$(echo $RAW | jq -r '.duration')
ELAPSED=$(echo $RAW | jq -r '.elapsedTimeNow')

# If both title and artist are missing, treat as nothing playing
if [ -z "$TITLE" ] && [ -z "$ARTIST" ]; then
	echo "♫ Nothing playing"
	exit 0
fi

TITLE=${TITLE:-"Unknown Title"}
ARTIST=${ARTIST:-"Unknown Artist"}

format_time() {
	local total_seconds=${1%.*}   # truncate decimals
  total_seconds=${total_seconds:-0}
	printf "%d:%02d" $((total_seconds / 60)) $((total_seconds % 60))
}

ELAPSED_FMT=$(format_time "$ELAPSED")
DURATION_FMT=$(format_time "$DURATION")

echo "♫ ${ARTIST} - ${TITLE} (${ELAPSED_FMT} / ${DURATION_FMT})"
