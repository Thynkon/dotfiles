TMP=$(mktemp /tmp/screenshot-XXXX.png)

grim -g "$(slurp)" "$TMP"
swappy -f "$TMP"

FILE=$(zenity --file-selection --save --confirm-overwrite --filename=screenshot.png)

[ -n "$FILE" ] && mv "$TMP" "$FILE" || rm "$TMP"
