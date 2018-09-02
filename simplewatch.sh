cd $(dirname "$0")
source ~/Documents/dev/py/Threatron/config.sh
quality="best\n720p60\n720p\n480p\n360p\naudio_only"
oauth="$(cat oauth|tr -d '\n')"
if [ $vod_mode = "false" ] ;
then
    channel=$(curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
	-H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
	-H "Authorization: OAuth $oauth" \ -X GET 'https://api.twitch.tv/kraken/streams/followed' | jq -c '.streams[] | {"":.channel | {Streamer: .name,playing: .game}, for: .viewers, viewers: .video_height}'  |tr -d '{' | tr -d '}' |tr '"' ' '|tr -d ','| tr -d ':' | awk '{print $0"p"}'| rofi -dmenu | awk '{print $2}')
fi
if [ $vod_mode = "true" ] ;
then
    channel=$(rofi -dmenu)
    id=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
    -H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
    -X GET "https://api.twitch.tv/kraken/users?login=$channel" | jq -c '.users[] |._id'| tr -d '"' )
    video=$(curl -H 'Accept: application/vnd.twitchtv.v5+json' \
	-H 'Client-ID: fendbm5b5q1c2820m59sbdv9z95vs4' \
	-H "Authorization: OAuth $oauth" \ -X GET "https://api.twitch.tv/kraken/channels/$id/videos?limit=25" | jq -c '.videos[] | {Created_at : .created_at , title : .title, url: .url}' | tr -d '{' | tr -d '}' | tr ',' ' ' | tr ':' ' ' | tr -d '"' | rofi -dmenu | awk 'NF>1{print $NF}')
	streamlink $video best
fi
picked_quality="best"
if [ $always_best= "false" ] ;
then
    picked_quality="$(echo -e $quality | rofi -dmenu)"
fi
if [ $popup_chat= "true" ] ;then
    xdg-open https://www.twitch.tv/popout/$channel/chat?popout=
fi
streamlink www.twitch.tv/$channel $picked_quality

