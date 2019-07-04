import spotipy

# SPOTIPY DOESN'T SEEM TO WORK
#
# scope = 'user-library-read'
#username = sys.argv[1]
# c_id = sys.argv[2]
# c_secret = sys.argv[3]
# redirect = 'https://example.com/'# 'https://127.0.0.1:8080/index.html'
# token = util.prompt_for_user_token(username, scope,c_id,c_secret,redirect)


token = # Copy from the online console
if token:
    sp = spotipy.Spotify(auth=token)
    results = sp.current_user_saved_tracks()
    for item in results['items']:
        track = item['track']
        print (track['name'] + ' - ' + track['artists'][0]['name'])
else:
    print ("Can't get token")

