cd $(dirname "$0")
config=$(readlink -f config.sh)
source $config
quality="best\n720p60\n720p\n480p\n360p\naudio_only"
oauth="$(cat oauth|tr -d '\n')"
if [ $vod_mode = "false" ] ;
then
    channel=$(curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
	-H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
	-H "Authorization: OAuth $oauth" \ -X GET 'https://api.twitch.tv/kraken/streams/followed' | jq -c '.streams[] | {"":.channel | {Streamer: .name,playing: .game}, for: .viewers, viewers: .video_height}'  |tr -d '{' | tr -d '}' |tr '"' ' '|tr -d ','| tr -d ':' | awk '{print $0"p"}'| rofi -dmenu)
    not_following=$(echo $channel | awk '{print $2}')
    if [ -z $not_following ];then
	echo "empty"
    else
	channel=$not_following
    fi
fi

if [ $vod_mode = "true" ]
    #čšć is used to sanitize output easier, so we don't remove every : but only the json key:value colon
then
    channel=$(rofi -dmenu)
    id=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/users?login=$channel" | jq -c '.users[] |._id'| tr -d '"' )
    video=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
	-H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
	-H "Authorization: OAuth $oauth" \ -X GET "https://api.twitch.tv/kraken/channels/$id/videos?limit=$vod_mode_limit" | jq -c '.videos[] | {"čšć" : .title, "(čšć": .created_at, ") čšć": .url}'|tr -d '{' | tr -d '}' | tr ',' ' ' | tr -d '"' | sed 's/čšć://g'| rofi -dmenu | awk 'NF>1{print $NF}')
fi
picked_quality="best"
if [ $always_best = "false" ] ;
then
    picked_quality="$(echo -e $quality | rofi -dmenu)"
fi
if [ $popup_chat = "true" ] ;then
    echo xd
    xdg-open https://www.twitch.tv/popout/$channel/chat?popout= 
fi
if [ $vod_mode = "true" ] ;
then
    streamlink $video $picked_quality &
else
    streamlink www.twitch.tv/$channel $picked_quality &
fi



