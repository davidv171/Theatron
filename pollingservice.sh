#!/bin/bash
cd $(dirname "$0")
interval=60
notify_me="reckful,imaqtpie,strawbunnyhunny,pokimane,radpuppy,sodapoppin,methodjosh,nerites"
while true
do
    id=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/users?login=$notify_me" | jq -c '.users[] |._id'| tr -d '"' | tr '\n' ',')
    live=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/streams/?channel=$id" | jq -c '.streams[] | .channel | {"": .name , " playing " : .game}' | tr -d '\{\}\,\"\:' | awk '{print $0"\n"}')
    echo $live
    if [ -z "$live" ]; then
	echo "No one is on"
    else
	notify-send "Theatron" "$live"
	name=$(echo $live | awk '{print $1}')
	notify_me="${notify_me//$name}"
	echo $notify_me
    fi
    sleep $interval
done
