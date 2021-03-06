#!/bin/bash
# Description: download national geographic photo of the day and set it as background
# copy from https://github.com/roylez/dotfiles/blob/master/bin/ng_background

# wait for network connection to be established
[[ -n $1 ]] && sleep $1

resolution=$(xrandr |grep -o 'current [^,]*'|tr -d " "|sed 's:current::')

#pod_page=`wget -q -O - http://photography.nationalgeographic.com/photography/photo-of-the-day/`
#img_url=$(echo $pod_page|grep -m 1 "http://images.nationalgeographic.com/[^\" ]*wallpaper[^\"]*.jpg" -o|head -1)

#rss=`tsocks wget -q -O - http://feeds.nationalgeographic.com/ng/photography/photo-of-the-day/`
rss=`wget -q -O - http://feeds.nationalgeographic.com/ng/photography/photo-of-the-day/`
img_url=$(echo $rss|grep -o "http://[^\" ]*/exposure/[^\"]*"|head -1|sed -s "s:360x270:$resolution:")
img=/tmp/pod.jpg

echo Image URL: $img_url
#tsocks wget -q -O $img $img_url
wget -q -O $img $img_url
echo "Download completed"

gsettings set org.gnome.desktop.background picture-uri "file://$img"
