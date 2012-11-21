ARTE Mediathek, oder auch: 8 Tage spaeter!
##########################################
:date: 2012-02-21 02:46
:tags: bash, de, source code

Habe vor einer etwas laengeren Zeit mich mit der Arte Mediathek
auseinandergesetzt. Neuerdings beruhen diese Mediatheken ja auf RTMP
Streams, was das Leben ein wenig erleichtert ;) Herrausgekommen ist ein
kleines Script welches rtmpdump nimmt und zumindest von Arte
runterlaedt.

 .. code-block :: bash

    #!/bin/sh

    if [ -z "$1" ]; then
        echo "Usage: $0 "
        exit 1
    fi

    url1=$(curl -s "$1" | grep "vars_player.videorefFileUrl" | sed 's/.*"\([^"]*\)";/\1/g')
    url2=$(curl -s "$url1" | grep 'video lang="de"' | sed 's/.*ref="\([^"]*\)".*/\1/g')
    url3=$(curl -s "$url2" | grep 'url quality="hd"' | sed 's/<[^>]*>//g')

    rtmpdump -W 'http://videos.arte.tv/blob/web/i18n/view/player_18-3188338-data-4921491.swf' -r "$url3" -o "$(basename "$url2" ",view,asPlayerXml.xml").mp4"

so long
