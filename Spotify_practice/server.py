##################################
# Script for accessing a user's  #
# Spotify account and removing   #
# duplicate songs from their     #
# playlists                      #
##################################

import spotipy
from config import token, username


def get_playlists(spotify):
    r = []
    empty = False
    offset = 0
    while not empty:
        result = spotify.current_user_playlists(limit=50, offset=offset)
        offset += 50
        if len(result['items']) == 0:
            empty = True
        else:
            r.append(result)
    return r


def get_tracks(spotify, playlist):
    tracks = []
    empty = False
    offset = 0
    while not empty:
        result = spotify.user_playlist_tracks(username,playlist,fields=None,limit=100,offset=offset,market=None)
        offset += 50
        if len(result['items']) == 0:
            empty = True
        elif len(result['items']) < 50:
            tracks += result['items']
            empty = True
        else:
            tracks += result['items']
    return tracks


def script():
    if token and username:
        sp = spotipy.Spotify(auth=token)
        results = get_playlists(sp)
        print(results)
        for result in results:
            for item in result['items']:
                if item['owner']['id'] == username:
                    print('************************')
                    print(item['name'])
                    print(item['id'])
                    print("\n")
                    print(len(get_tracks(sp, item['id'])))
                    print('************************')
    else:
        print("Can't get token or username")


script()
