#!/usr/bin/env python
from soco import SoCo

if __name__ == '__main__':
    sonos = SoCo('192.168.110.175') # Pass in the IP of your Sonos speaker

    track = sonos.get_current_track_info()
    state = sonos.get_current_transport_info()

    artist = track['artist']
    name = track['title']
    album = track['album']
    position = track['position'][2:]
    duration = track['duration'][2:]

    nothing = "Nothing playing :("
    np = artist + " - " + name + " (" + album + ") (" + position + " / " + duration + ")"

    if state['current_transport_state'] == "STOPPED":
        print(nothing)
    else:
        print(np)

