# Tidal (Mopidy)

Streams your Tidal subscription through this host's sound card via
[Mopidy](https://mopidy.com) + [Mopidy-Tidal](https://github.com/tehkillerbee/mopidy-tidal)
with the [Iris](https://github.com/jaedb/iris) web UI on port **6680**.

## First login

1. In Iris, browse to **Tidal** — while logged out it shows a single
   entry "Please visit https://link.tidal.com/… to log in."
2. Open that entry's three-dot menu and choose **Copy URLs** — the
   add-on patches mopidy-tidal's login hack so the copied URI is the
   real `link.tidal.com` address.
3. Paste the URL into a new browser tab, log in and authorize the
   device (paid subscription required).
4. The session file persists in the add-on's `/data` directory, so
   restarts stay logged in.

Requires a **paid Tidal subscription**. The "quality" option selects
the stream quality (LOSSLESS = FLAC).

## Options

| Option | Default | Purpose |
|---|---|---|
| `audio_device` | `default` | ALSA device string, e.g. `hw:0,0` — see `aplay -l` on the host |
| `quality` | `LOSSLESS` | `LOSSLESS`, `HIGH` or `LOW` |

## Playback

- **Iris web UI** (`:6680`) — browse Tidal, control playback.
- **MPD port** (`:6600`) — any MPD client works too.
