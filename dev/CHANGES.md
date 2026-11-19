# CHANGES

## 26-11-19 — tidal add-on 0.1.0

- `tidal/`: Mopidy + mopidy-tidal + mopidy-iris + mopidy-mpd on
  debian:trixie-slim. Web UI :6680 (Iris), MPD :6600, PKCE login
  callback :8989, `/dev/snd` passthrough for host sound card.
- Pins: `mopidy<4` (iris imports mopidy.models.serialize — removed in
  Mopidy 4), `setuptools<81` (pkg_resources removed in v81).
- Chosen because every Tidal Connect image is ARM-only (closed-source
  Tidal binary) — nebelhaufen is x86.
- Verified on nebelhaufen: container up, Iris 200, MPD banner, ALSA
  sees HDA Intel ALC262.
