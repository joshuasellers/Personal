from instagram.client import InstagramAPI

access_token = "cbb74e4a232c4d6b9873e4cdb90c08f0"
client_secret = "d3a80cbd6af94408b3698ffef1e42c79"
api = InstagramAPI(access_token=access_token, client_secret=client_secret)
recent_media, next_ = api.user_recent_media(user_id="jsellers216", count=10)
for media in recent_media:
   print(media.caption.text)