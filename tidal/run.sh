#!/bin/bash
# Generates mopidy.conf from /data/options.json and runs Mopidy.
# Mopidy-Tidal uses PKCE auth: browsing Tidal in the UI logs a
# login.tidal.com URL; after the browser authorizes, Tidal redirects to
# the container's login server on port 8989. Session persists in /data.
set -e

DATA=/data
OPTIONS="$DATA/options.json"
[ -f "$OPTIONS" ] || echo '{}' > "$OPTIONS"
mkdir -p "$DATA/media"
read AUDIO_DEV QUALITY < <(python3 - "$OPTIONS" <<'PY'
import json, sys
o = json.load(open(sys.argv[1]))
print(o.get("audio_device", "default"), o.get("quality", "LOSSLESS"))
PY
)

cat > "$DATA/mopidy.conf" <<CONF
[core]
data_dir = $DATA/mopidy-data
cache_dir = $DATA/cache

[audio]
output = alsasink device=$AUDIO_DEV

[http]
hostname = 0.0.0.0
port = 6680

[iris]
enabled = true
country = DE
locale = de_DE

[file]
enabled = true
media_dirs =
    /data/media|Media

[mpd]
hostname = 0.0.0.0
port = 6600

[tidal]
enabled = true
quality = $QUALITY
login_method = AUTO
CONF

echo "[tidal] starting mopidy (audio=$AUDIO_DEV, quality=$QUALITY)"
echo "[tidal] first login: Iris - Tidal - 3-dot menu - Copy URLs, paste in browser"
exec mopidy --config "$DATA/mopidy.conf"
