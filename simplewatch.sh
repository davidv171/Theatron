channel=$(curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -H 'Authorization: OAuth 8zby9dk50bri0n75enbu0nwjpyg0qq' \ -X GET 'https://api.twitch.tv/kraken/streams/followed' | jq -r '.streams[] | .channel| .name' | rofi -dmenu)
streamlink www.twitch.tv/$channel best

