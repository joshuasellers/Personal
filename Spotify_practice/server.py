import spotipy

# SPOTIPY DOESN'T SEEM TO WORK
#
# scope = 'user-library-read'
#username = sys.argv[1]
# c_id = sys.argv[2]
# c_secret = sys.argv[3]
# redirect = 'https://example.com/'# 'https://127.0.0.1:8080/index.html'
# token = util.prompt_for_user_token(username, scope,c_id,c_secret,redirect)


token = 'BQDu_57MQ-KT8Qu03lZIFppbqy-Z5wxJyhG9W-VVfvHq0jlcN1gRmYAluMIoaZ90TqyvITqxHhy-KvgT65Onl66f2X5G5LpASGLAjbGI7fu_hUQVdp9mpQKMexO-iIyLvaPbCji-aYutafHVfckQF2C_r5WTC6ucC5A9k-vF9WPCon5yPIxY8_O6ulgdTXBaGeesKCov2srTbWD2PwWGn1w00HwCne4nBzYIBE2WrC28OJyulRY9yNR-8ENbJcVTSQ4mIAEl-Eh5yOg4qhSVlFmiPILAsZTV1ug9MEg'
if token:
    sp = spotipy.Spotify(auth=token)
    results = sp.current_user_saved_tracks()
    for item in results['items']:
        track = item['track']
        print (track['name'] + ' - ' + track['artists'][0]['name'])
else:
    print ("Can't get token")

