import http.server
import socketserver
import spotipy

import sys
import spotipy
import spotipy.util as util

# SET UP LOCALHOST

PORT = 8000
Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("serving at port", PORT)

    # CALL TO SPOTIFY API

    scope = 'user-library-read'
    username = sys.argv[1]
    c_id = sys.argv[2]
    c_secret = sys.argv[3]
    redirect = sys.argv[4]

    token = util.prompt_for_user_token(username, scope,c_id,c_secret,redirect)

    if token:
        sp = spotipy.Spotify(auth=token)
        results = sp.current_user_saved_tracks()
        for item in results['items']:
            track = item['track']
            print (track['name'] + ' - ' + track['artists'][0]['name'])
    else:
        print ("Can't get token for", username)

    #httpd.serve_forever()