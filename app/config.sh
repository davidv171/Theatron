#!/usr/bin/env bash
#dont ask for quality, always just run the best one, always worst might be implemented if anyone asks
always_best=false

#The default player used by streamlink with the latest breakage of VLC we can't rely on it anymore :(
player="mpv"

#The default application launcher, currently tested on: rofi, dmenu, smenu. Only use 1 at a time
#For the main 3:
#launcher="rofi -dmenu"
#launcher="dmenu"
#launcher="smenu -t"
launcher="choose"
#if this is on, every time you pick a streamer, you will get vod menu after you pick a streamer, the first entry should still be the live stream
vod_mode=true

browse_type_option_followed_channels="Channels you're following"
browse_type_option_followed_games="Games you're following"
browse_type_option_all_games="All games"
#Set the browse type to skip being asked for it every time. Set it to empty to be asked. The options are above.
default_browse_type=''
#default_browse_type=$browse_type_option_followed_channels
#default_browse_type=$browse_type_option_followed_games
#default_browse_type=$browse_type_option_all_games

# How many vods(filtered by recency) to show
vod_mode_limit="25"

#if true, opens up a browser window with the chat popup mode of the picked streamer, does so not knowingly if the stream loaded or not
popup_chat=false
#set up custom streamlink flags
streamlink_flags="--player-continuous-http"
#If you want clip capatibilities, if you change this from false to true you will need a new token, easiest way to obtain it is to delete oauth file, because it requires elevated privileges
clip_capabilities=true
#App settings, for global, don't change
client_id="hhbyqx97pd0isx67ig1ygch9v6qslk"
redirect_uri="https://gitlab.com/davidv171/Theatron"
