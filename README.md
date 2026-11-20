# tidal-addon

A local [homeassistant-apps](https://github.com/rubo77/homeassistant-apps)
add-on repository — part of the
[rubo77/homeassistant-apps](https://github.com/rubo77/homeassistant-apps)
project — offering **Tidal (Mopidy)**, a Tidal streaming client that
plays through the host's sound card.

Built for Home Assistant Core installs without Supervisor, where the
"Apps" section is missing. The add-on runs as a plain Docker container
and appears in the ha-apps panel under the **local** repository.

## What it provides

- **Mopidy + Mopidy-Tidal** — streams your Tidal subscription
- **Iris web UI** on port **6680** — browse Tidal, control playback
- **MPD port 6600** — any MPD client works too
- **PKCE login** on port 8989 — the OAuth callback for Tidal login
- **ALSA passthrough** (`/dev/snd`) — audio goes to the host's sound card

## Requirements

- A **paid Tidal subscription**
- Docker on the HA host (ha-apps installs it as a container)
- An ALSA sound device on the host (`aplay -l` to list)

## Install

1. Sync this repository to the ha-apps local repo path
   (`/var/lib/ha_apps/local` on the HA host — see
   `HA_APPS_LOCAL_REPO` in `dev/.env`).
2. In Home Assistant open **Apps** → filter **local** → **Tidal
   (Mopidy)** → Install.
3. Open the Iris UI on `http://<host>:6680/`.

## First login

1. In Iris, browse to **Tidal** — while logged out it shows a single
   entry "Please visit https://link.tidal.com/… to log in."
2. Open that entry's three-dot menu and choose **Copy URLs** — the
   add-on patches mopidy-tidal's login hack so the copied URI is the
   real `link.tidal.com` address.
3. Paste the URL into a new browser tab, log in and authorize the
   device.
4. The session file persists in the add-on's `/data` directory, so
   restarts stay logged in.

## Options

| Option | Default | Purpose |
|---|---|---|
| `audio_device` | `default` | ALSA device string, e.g. `hw:0,0` — see `aplay -l` on the host |
| `quality` | `LOSSLESS` | `LOSSLESS`, `HIGH` or `LOW` |

## Ports

| Port | Service |
|---|---|
| 6680 | Iris web UI |
| 6600 | MPD control |
| 8989 | Tidal PKCE login callback (internal) |

## Notes

- The image is built from `tidal/Dockerfile` on first install — based
  on `debian:trixie-slim`, installs Mopidy + mopidy-tidal + mopidy-iris
  + mopidy-mpd.
- `patch_login_hack.py` fixes mopidy-tidal's login URIs so Iris' "Copy
  URLs" yields a usable `link.tidal.com` URL.
- Pins: `mopidy<4` (iris imports `mopidy.models.serialize`, removed in
  Mopidy 4) and `setuptools<81` (`pkg_resources` removed in v81).
- Chosen over Tidal Connect images because those are ARM-only
  (closed-source Tidal binary); this works on x86 and ARM.

## Repo layout

```
repository.yaml   # ha-apps repository manifest (name, maintainer)
tidal/            # the add-on: Dockerfile, config.yaml, run.sh, patch
dev/              # local dev notes (not deployed)
```
