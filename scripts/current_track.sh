#!/bin/bash

NOW_PLAYING=$(osascript <<EOF
set spotify_state to false
set itunes_state to false

if is_app_running("Spotify") then
	tell application "Spotify" to set spotify_state to (player state as text)
end if
if is_app_running("iTunes") then
	tell application "iTunes" to set itunes_state to (player state as text)
end if

if spotify_state is equal to "playing" then
	tell application "Spotify"
		set track_name to name of current track
		set artist_name to artist of current track
		set album_name to album of current track
		set play_count to played count of current track
		set player_position to player position
		set track_duration to (duration of current track) / 1000
		
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
		set minutes to 0
		repeat while player_position is greater than 59
			if player_position is greater than 59 then
				set minutes to minutes + 1
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
		
		-- Add player state emojis
		if shuffling then
			set is_shuffle to " 🔀"
		else
			set is_shuffle to ""
		end if
		
		if repeating then
			set is_repeat to " 🔁"
		else
			set is_repeat to ""
		end if
		
		return "♫ " & artist_name & " - " & track_name & " (" & minutes & ":" & player_position & " / " & total_minutes & ":" & total_seconds & ")" & is_shuffle & is_repeat
	end tell
else if itunes_state is equal to "playing" then
	tell application "iTunes"
		set track_name to name of current track
		set artist_name to artist of current track
		return "#[bold]" & artist_name & "#[nobold] - " & track_name
	end tell
else
	return "Nothing playing :("
end if

on track_time(position, duration)
	return duration
end track_time

on is_app_running(app_name)
	tell application "System Events" to (name of processes) contains app_name
end is_app_running
EOF)

echo $NOW_PLAYING
