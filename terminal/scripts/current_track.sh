#!/bin/bash

RAW=$(media-control get --now)
TITLE=$(echo $RAW | jq -r '.title')
ARTIST=$(echo $RAW | jq -r '.artist')
DURATION=$(echo $RAW | jq -r '.duration')
ELAPSED=$(echo $RAW | jq -r '.elapsedTimeNow')

format_time() {
	local total_seconds=${1%.*}   # truncate decimals
	printf "%d:%02d" $((total_seconds / 60)) $((total_seconds % 60))
}

ELAPSED_FMT=$(format_time "$ELAPSED")
DURATION_FMT=$(format_time "$DURATION")

echo "♫ ${ARTIST} - ${TITLE} (${ELAPSED_FMT} / ${DURATION_FMT})"
