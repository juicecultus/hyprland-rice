#!/bin/bash
# Waybar network module via NetworkManager — reliable SSID on Broadcom BCM4350
# (waybar's native nl80211 essid read is flaky on this chip).

# wired first
wired=$(nmcli -t -f DEVICE,TYPE,STATE device 2>/dev/null \
        | awk -F: '$2=="ethernet" && $3=="connected"{print $1; exit}')
if [ -n "$wired" ]; then
    ip=$(nmcli -g IP4.ADDRESS device show "$wired" 2>/dev/null | head -1 | cut -d/ -f1)
    printf '{"text":"󰈀  wired","tooltip":"%s — %s","class":"connected"}\n' "$wired" "$ip"
    exit 0
fi

# active wifi connection
read -r ssid signal < <(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi 2>/dev/null \
        | awk -F: '$1=="yes"{print $2, $3; exit}')
if [ -n "$ssid" ]; then
    dev=$(nmcli -t -f DEVICE,TYPE,STATE device 2>/dev/null | awk -F: '$2=="wifi" && $3=="connected"{print $1; exit}')
    ip=$(nmcli -g IP4.ADDRESS device show "$dev" 2>/dev/null | head -1 | cut -d/ -f1)
    sig=${signal:-0}
    if   [ "$sig" -ge 75 ]; then ic="󰤨"
    elif [ "$sig" -ge 50 ]; then ic="󰤥"
    elif [ "$sig" -ge 25 ]; then ic="󰤢"
    else                          ic="󰤟"; fi
    printf '{"text":"%s  %s","tooltip":"%s   %s%%\\n%s","class":"connected"}\n' "$ic" "$ssid" "$ssid" "$sig" "$ip"
else
    printf '{"text":"󰤬  off","tooltip":"disconnected","class":"disconnected"}\n'
fi
