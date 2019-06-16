# Test file for spotipy
#
# By Josh Sellers
#
# Just testing out the code before my actual coding
#


import sys
import spotipy
import spotipy.util as util


scope = 'user-library-read'

if len(sys.argv) > 1:
    username = sys.argv[1]
else:
    print "Usage: %s username" % (sys.argv[0],)
    sys.exit()

token = util.prompt_for_user_token(username, scope,client_id='d7ad0b4202814cb7bf6114e0fc442220',
                                   client_secret='d7dbb19839fd4ffd81e99af9b2098c21')

if token:
    sp = spotipy.Spotify(auth=token)
    results = sp.current_user_saved_tracks()
    for item in results['items']:
        track = item['track']
        print track['name'] + ' - ' + track['artists'][0]['name']
else:
    print "Can't get token for", username