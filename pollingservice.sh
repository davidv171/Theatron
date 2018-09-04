cd $(dirname "$0")
config=$(readlink -f notifconf.sh)
source $config
while true
do  
    id=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/users?login=$notify_me" | jq -c '.users[] |._id'| tr -d '"' | tr '\n' ',')
    echo $id
    live=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/streams/?channel=$id" | jq -c '.streams[] | .channel | {Streamer : .name , playing : .game}' | tr -d '{' | tr -d '}' | tr ',' ' ' | tr -d '"' | tr ':' ' ')
    echo $live
    if [ -z "$live" ]; then
	echo "No one is on"
    else
	notify-send "Theatron" "$live"
	name=$(echo $live | awk '{print $2","}')
	notify_me="${notify_me//$name}"
    fi
    sleep $interval
done
