#!/bin/sh
#Sélectionne un wallpaper parmis tous les fichiers d'un dossier
#Fonctionne avec les sous dossiers \o/

dir="/media/win/Users/Bob/Pictures"
walls=$(find $dir -type f | grep ".\.[jpg|jpeg|png]")

wall=$(echo "$walls" | tail -$((RANDOM % $(echo "$walls" | wc -l))) | head -n 1)
feh --bg-scale "$wall"
