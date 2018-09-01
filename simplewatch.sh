oauth="$(cat oauth|tr -d '\n')"
channel=$(curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -H "Authorization: OAuth $oauth" \ -X GET 'https://api.twitch.tv/kraken/streams/followed' | jq -c '.streams[] | .channel| {Streamer:.name,playing:.game}' | tr -d '{' | tr -d '}' |tr '"' ' ' | rofi -dmenu)
streamlink www.twitch.tv/$channel best

