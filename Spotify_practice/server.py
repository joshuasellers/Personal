##################################
# Script for accessing a user's  #
# Spotify account and removing   #
# duplicate songs from their     #
# playlists                      #
##################################

import spotipy
from config import token, username

if token and username:
    sp = spotipy.Spotify(auth=token)
    results = []
    empty = False
    offset = 0
    while not empty:
        result = sp.current_user_playlists(limit=50, offset=offset)
        offset += 50
        if len(result['items']) == 0:
            empty = True
        else:
            results.append(result)
    print(results)
    for result in results:
        for item in result['items']:
            if item['owner']['id'] == username:
                print('************************')
                print(item['name'])
                print(item['id'])
                print('************************')

else:
    print("Can't get token or username")

