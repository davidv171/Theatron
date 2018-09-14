if [[ $1 = "-v" ]]
then
    echo "0.5"
    exit 0
fi
cd $(dirname "$0")
config=$(readlink -f config.sh)
source $config
quality="best\n720p60\n720p\n480p\n360p\naudio_only"
oauth="$(cat oauth|tr -d '\n')"
    channel=$(curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
	-H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
	-H "Authorization: OAuth $oauth" \ -X GET 'https://api.twitch.tv/kraken/streams/followed' | jq -c '.streams[] | {"":.channel | {Streamer: .name,playing: .game}, for: .viewers, viewers: .video_height}'  |tr -d '{' | tr -d '}' |tr '"' ' '|tr -d ','| tr -d ':' | awk '{print $0"p"}'| rofi -dmenu)
    not_following=$(echo $channel | awk '{print $2}')
if [[ -n $not_following ]];then
    channel=$not_following
fi
if [[ -z $channel ]]
then
    exit 1
fi
if [[ $vod_mode = "true" ]]
    #čšć is used to sanitize output easier, so we don't remove every : but only the json key:value colon
then
    id=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/users?login=$channel" | jq -c '.users[] | ._id' | tr -d '"' )
    live=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \ -X GET "https://api.twitch.tv/kraken/streams/$id"| jq -r '.stream')
    if  [[ $live != "null"* ]]; then
	live="Channel is live, click me to watch"
    else
	live="Channel is not yet live, use polling service and wait :( "
    fi
    video=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
	-H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
	-H "Authorization: OAuth $oauth" \ -X GET "https://api.twitch.tv/kraken/channels/$id/videos?limit=$vod_mode_limit" | jq -c --unbuffered '.videos[] | {"čšć" : .title, "(čšć": .created_at, ") čšć": .url}'|tr -d '{' | tr -d '}' | tr ',' ' ' | tr -d '"' | sed 's/čšć://g' | printf "%s\n%s" "$live" "$(cat -)" | rofi -dmenu | awk 'NF>0{print $NF}')
fi
picked_quality="best"
if [[ $always_best = "false"  &&  -n $video ]];
then
    picked_quality="$(echo -e $quality | rofi -dmenu)"
fi
if [ $popup_chat = "true" ] ;then
    xdg-open https://www.twitch.tv/popout/$channel/chat?popout= 
fi
if [[ $vod_mode = "true" ]] ;
then
    if [[ $video = "watch" ]] ; then
	streamlink www.twitch.tv/$channel $picked_quality &
    else
	streamlink $video $picked_quality &
    fi  
else
    streamlink www.twitch.tv/$channel $picked_quality &
fi



