# Theatron

## ALERT

**NEWEST VLC VERSION(3.0.4-0) does NOT WORK WITH TWITCH, downgrade to 3.0.3 or set up a different default video playyer**

A simple app to display Live channels through Rofi. My attempt at giving back to the open source community. Disclaimer: the app is not as cool as the name is.

## Yeah but how does it look like?

Here's a demo:


[![DEMO](https://0x0.st/s3yP.png)](https://imgur.com/tDnm3A5)

## How to install

Currently all we have is a file. If you have streamlink + rofi, add a file called `oauth` in the project root folder. Run it with//whateve.

Let's assume you're using Arch Linux.

The easiest way to install the dependencies is:

`sudo pacman -S streamlink rofi jq`

After you're done installing or during(if you have bad internet),visit:

https://twitchapps.com/tmi/

Get the oauth key and remove the oauth: bit in front of it.

Since this is still in early beta, we'll assume you installed using git.

1. Visit your repository location
2. Create a new file called `oauth` this is the file name always. Put in your oauth key without the oauth: bit! This is very important if you want a follow list
3. run  simplewatch`
4. Hopefully, you did everything right, so itowed you a bunch of streamers you follow that are online, their viewers and their best possible quality! Look at ## Configuration for more
5. Pick a streamer in your rofi menu using arrow keys,search bar + enter or clicking.
6. Pick a quality(be careful, idly choosing 720p60 even if a streamer's maximum quality is 480p will not work. Ask streamlink. The safest is to use best/worst. That always works.
7. Streamlink takes over.
8. Tell me about bugs! This is a small, solo project and I appreciate any sort of bug reports, feature requests or even pull requests!


## What's new in the test branch

version: 0.5.3:

- Remove oauth calls where not needed
- Config now has options where you get to pick your own video player

If you don't know what to do with this info, please make sure to reread the readme and maybe stick it out with the masters branch a bit longer :). Don't hesitate to open issues.

## Running the script

This script contains 4 main parts. A notification script(runs in the background andould only notify you when a streamer is coming online) and the simplewatch script. That is the script thatows you the streamers you are following that are currently online. Both need a config file. If you installed this through git, they have the example configs already.

If you don't know how Rofi works:

Use arrows or type into the search bar. You can type in a string that is NOT ON THE LIST. This is very important. So let's say you don't even follow "Imaqtpie", but you know he's on at this time, and want to watch. Simply type :

Imaqtpie into the search bar and press enter. Hopefully streamlink will load up the video too.

## Flags

sh streamlink -v

Outputs the version of the main script(notification script probably will not be updated a lot if at all, so it doesnt need versioning for now).

sh streamlink -p

Should popout chat no matter what your config says.

## Configuration

The repo contains an example configuration. The comments should explain everything. Just like the oauth file this needs to be in the same directory as the script.

In case you ever change your default configuration, this is an example of it:

```

#dont ask for quality, always just run the best one, always worst might be implemented if anyone asks
always_best=false

#The default player used by streamlink with the latest breakage of VLC we can't rely on it anymore :(
player="mpv"

#if this is on, every time you pick a streamer, you will get vod menu after you pick a streamer, the first entry should still be the live stream
vod_mode=true

# How many vods(filtered by recency) to show
vod_mode_limit="25"

 #if true, opens up a browser window with the chat popup mode of the picked streamer, does so not knowingly if the stream loaded or not
popup_chat=false

```

## Notifications

Notifications are a separate script, that can be used without the main Theatron application OR A LOGIN. The script simply checks for a select few streamers you specify inside the notifconf file and queries on a set interval(also specified by your config file)

If there is any type of request, I can add a way to check without a config file with login, but most people only have notifications for the very few streamers they watch, so my thought process was that it was way easier to type them in.

**Make an issue if you want this implemented**

Or I will implement it when I get bored.

### Dependencies

Notifications script mostly only relies on jq and curl. After that it sends a "notify-send" that is then taken care of by a notification daemon.

## TODO

- Extensibility, modularity, basically let the user decide on every part of the program

- Usability without oauth! This will probably be implemented in python

- Let user decide on output

