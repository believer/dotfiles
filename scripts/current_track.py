#!/usr/bin/env python
from soco import SoCo

if __name__ == '__main__':
    sonos = SoCo('192.168.110.175') # Pass in the IP of your Sonos speaker

    track = sonos.get_current_track_info()
    state = sonos.get_current_transport_info()

    artist = track['artist'].decode('utf-8')
    name = track['title'].decode('utf-8')
    album = track['album'].decode('utf-8')
    position = track['position'][2:]
    duration = track['duration'][2:]

    if state['current_transport_state'] == "STOPPED":
        print "Nothing playing :("
    else:
        print artist + " - " + name + " (" + album + ") (" + position + " / " + duration + ")"

