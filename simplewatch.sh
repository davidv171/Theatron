quality="audio_only\nworst\n360p\n480p\n720p\n720p60\nbest"
oauth="$(cat oauth|tr -d '\n')"
channel=$(curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -H "Authorization: OAuth $oauth" \ -X GET 'https://api.twitch.tv/kraken/streams/followed' | jq -c '.streams[] | {"":.channel | {Streamer: .name,playing: .game}, for: .viewers, viewers: .video_height}'  |tr -d '{' | tr -d '}' |tr '"' ' '| tr -d ':' | rofi -dmenu | awk '{print $2}')
picked_quality="$(echo -e $quality | rofi -dmenu)"
streamlink www.twitch.tv/$channel $picked_quality

