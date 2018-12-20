#!/bin/bash

getFollowingChannels() {
     curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
        -H "Client-ID: $client_id" \
        -H "Authorization: OAuth $oauth" \
        -X GET "https://api.twitch.tv/kraken/streams/followed"\
        | jq -c '.streams[] | {"":.channel | {"Streamer ": .name , " playing ": .game}, " for ": .viewers, " viewers ": .video_height}'\
        | tr -d '\{\}\:\"\,'\
        | awk '{print $0"p"}'
}

getTwitchUserId() {
    curl -H 'Accept: application/vnd.twitchtv.v5+json' \
        -H "Client-ID: $client_id" \
        -H "Authorization: OAuth $oauth" \
        -X GET 'https://api.twitch.tv/kraken/user' \
        | jq -c '. | ._id' \
        | tr -d '"'
}

# First argument must be the twitch user id
getFollowingGames() {
    curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
       -H "Client-ID: $client_id" \
       -H "Authorization: OAuth $oauth" \
       -X GET "https://api.twitch.tv/kraken/users/${1}/follows/games" \
       | jq -c '.follows[] | {"": .game.popularity, " viewers - ": .game.name}' \
       | tr -d '\{\}\:\"\,'
}

# First argument must be the game's name
getChannelsFromGame() {
    curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
        -H "Client-ID: $client_id" \
        -H "Authorization: Oauth $oauth" \
        -X GET "https://api.twitch.tv/kraken/streams?game=${1}" \
        | jq -c '.streams[] | {"":.channel | {"Streamer ": .name , " playing ": .game}, " for ": .viewers, " viewers ": .video_height}'\
        | tr -d '\{\}\:\"\,'\
        | awk '{print $0"p"}'
}

getAllGames() {
    curl -s -H 'Accept: application/vnd.twitchtv.v5+json' \
        -H "Client-ID: $client_id" \
        -H "Authorization: OAuth $oauth" \
        -X GET 'https://api.twitch.tv/kraken/games/top?limit=100' \
        | jq -c '.top[] | {"": .viewers, " viewers - ": .game.name}' \
        | tr -d '\{\}\:\"\,'
}