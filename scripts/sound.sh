#!/bin/sh

function getMsg {
    echo "Titre : `mpc current -f %title%`"
    echo "Album: `mpc current -f %album%`"
    echo "Artise: `mpc current -f %artist%`"
    echo "Track : `mpc current -f %track%`"
    echo "Durée : `mpc current -f %time%`"
    echo "Volume : `amixer get Master | tail -1 | awk '{print $4 $6}'`"
}

function getCover {
    local DEFAULT_COVER="/path/to/defaultcover.png"

    local MUSICDIR="/media/win/Users/Bob/Music"

    local MFILEO=`mpc current -f %file%`
    local MFILE=${MFILEO%/*}
    MFILE=${MFILE%/$}

    local FULLDIR="$MUSICDIR/$MFILE"

    COVERS=`ls "$FULLDIR" | grep "\.jpg\|\.png\|\.gif"`

    if [ -z "$COVERS" ]; then
        COVERS="$DEFAULT_COVER"
    else
        local TRYCOVERS=`echo "$COVERS" | grep "cover\|front" | head -n 1`

        if [ -z "$TRYCOVERS" ]; then
            TRYCOVERS=`echo "$COVERS" | head -n 1`
            if [ -z "$TRYCOVERS" ]; then
                TRYCOVERS="$DEFAULT_COVER"
            else
                TRYCOVERS="$FULLDIR/$TRYCOVERS"
            fi
        else
            TRYCOVERS="$FULLDIR/$TRYCOVERS"
        fi

        COVERS="$TRYCOVERS"
    fi

    #echo $COVERS
    local TNAME=`echo "$MFILEO" | md5sum | cut -d" " -f1`
    TNAME="$TNAME.jpg"
    [ -e "/tmp/thumb" ] || mkdir /tmp/thumb
    convert -antialias -quality 75 -sample 100x100 "$COVERS" /tmp/thumb/$TNAME
    echo "/tmp/thumb/$TNAME"
}

case $1 in
    "toggle") mpc toggle;;
    "prev") mpc prev;;
    "next") mpc next;;
    "mute") amixer set Master toggle;;
    "up") amixer set Master 5%+;;
    "down") amixer set Master 5%-;;
esac

notify-send -i "`getCover`" "MPD Status" "`getMsg`"
