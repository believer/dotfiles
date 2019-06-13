#!/usr/bin/env python
from soco import SoCo

if __name__ == '__main__':
    sonos = SoCo('192.168.110.175') # Pass in the IP of your Sonos speaker

    track = sonos.get_current_track_info()
    state = sonos.get_current_transport_info()

    if state['current_transport_state'] == "STOPPED":
        print "Nothing playing :("
    else:
        print track['artist'] + " - " + track['title'], \
        "(" + track['album'] + ") (" + track['position'][2:], \
        "/ " + track['duration'][2:] + ")"

