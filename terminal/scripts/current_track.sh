#!/bin/bash

NOW_PLAYING=$(osascript <<EOF
set spotify_state to false
set itunes_state to false

if is_app_running("Spotify") then
	tell application "Spotify" to set spotify_state to (player state as text)
end if
if is_app_running("Music") then
	tell application "Music" to set itunes_state to (player state as text)
end if

if spotify_state is equal to "playing" then
	tell application "Spotify"
		set track_name to name of current track
		set artist_name to artist of current track
		set album_name to album of current track
		set play_count to played count of current track
		set player_position to player position
		set track_duration to (duration of current track) / 1000
		set is_shuffle to shuffling
		set is_repeat to repeating
		
		set track_position to my track_time(player_position, track_duration)
		set track_data to artist_name & " - " & track_name & " (" & album_name & ")" & track_position
		
		return my track_meta(track_data, is_shuffle, is_repeat)
	end tell
else if itunes_state is equal to "playing" then
	tell application "Music"
		set track_name to name of current track
		set artist_name to artist of current track
		set album_name to album of current track
		set player_position to player position
		set track_duration to (duration of current track)
		set is_shuffle to shuffle enabled
		set is_repeat to true
		set repeat_mode to song repeat
		
		if repeat_mode is equal to off then
			set is_repeat to false
		end if
		
		set track_position to my track_time(player_position, track_duration)
		set track_data to artist_name & " - " & track_name & " (" & album_name & ")" & track_position
		
		return my track_meta(track_data, is_shuffle, is_repeat)
	end tell
else
  do shell script "python3 ~/.dotfiles/terminal/scripts/current_track.py"
end if

on track_meta(track_data, is_shuffle, is_repeat)
	-- Add player state emojis
	if is_shuffle then
		set shuffle_str to " 🔀"
	else
		set shuffle_str to ""
	end if
	
	if is_repeat then
		set repeat_str to " 🔁"
	else
		set repeat_str to ""
	end if
	
	return "♫ " & track_data & shuffle_str & repeat_str
end track_meta

on track_time(player_position, track_duration)
	-- Set total times
	set total_minutes to round (track_duration / 60) rounding down
	set total_seconds to round ((track_duration / 60) - total_minutes) * 60
	
	if player_position is less than 60 then
		set player_position to round player_position rounding down
	end if
	
	if total_seconds is equal to 60 then
		set total_seconds to "00"
		set total_minutes to total_minutes + 1
	end if
	
	-- Calculate minutes
	set player_minutes to 0
	repeat while player_position is greater than 59
		if player_position is greater than 59 then
			set player_minutes to player_minutes + 1
			set player_position to round (player_position - 60) rounding down
		end if
	end repeat
	
	-- Add leading zeroes
	if player_position is less than 10 then
		set player_position to "0" & player_position
	end if
	
	if total_seconds is less than 10 and total_seconds is not equal to "00" then
		set total_seconds to "0" & total_seconds
	end if
	
	return " (" & player_minutes & ":" & player_position & " / " & total_minutes & ":" & total_seconds & ")"
end track_time

on is_app_running(app_name)
	tell application "System Events" to (name of processes) contains app_name
end is_app_running
EOF)

echo $NOW_PLAYING
