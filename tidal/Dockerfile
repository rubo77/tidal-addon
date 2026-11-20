# Tidal playback on x86/ARM via Mopidy + mopidy-tidal + Iris web UI.
# Tidal Connect itself is ARM-only (closed binary); mopidy-tidal is the
# open-source path that works on any architecture.
FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 python3-pip python3-gi \
        gir1.2-gstreamer-1.0 gir1.2-gst-plugins-base-1.0 \
        gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
        gstreamer1.0-libav gstreamer1.0-alsa \
        alsa-utils ca-certificates \
    && pip3 install --break-system-packages --no-cache-dir \
        --timeout 120 --retries 8 \
        mopidy mopidy-tidal mopidy-iris mopidy-mpd \
    && rm -rf /var/lib/apt/lists/*

# mopidy-iris needs Mopidy 3.x (v4 removed mopidy.models.serialize) and
# setuptools<81 (v81+ removed pkg_resources)
RUN pip3 install --break-system-packages --no-cache-dir \
        --timeout 120 --retries 8 \
        "mopidy<4" mopidy-tidal mopidy-iris mopidy-mpd "setuptools<81"

COPY patch_login_hack.py /patch_login_hack.py
RUN python3 /patch_login_hack.py

COPY run.sh /run.sh
ENTRYPOINT ["bash", "/run.sh"]
