import spotipy
from config import token

if token:
    sp = spotipy.Spotify(auth=token)
    results = []
    empty = False
    offset = 0
    while not empty:
        result = sp.current_user_playlists(limit=50, offset=offset)
        offset += 50
        if len(result['items']) == 0: empty = True
        else: results.append(result)
    print(results)
    for result in results:
        for item in result['items']:
            print(item['name'])
else:
    print ("Can't get token")

