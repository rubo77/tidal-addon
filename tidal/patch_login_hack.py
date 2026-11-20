# Point the login-hack placeholder objects' uri at the real login URL so
# Iris' "Copy URLs" context action copies a usable https link instead of
# tidal:*:login placeholders.
import pathlib

import mopidy_tidal.login_hack as lh

p = pathlib.Path(lh.__file__)
s = p.read_text()
pairs = [
    ('Track(uri="tidal:track:login", name=self.msg)',
     'Track(uri=self.url, name=self.msg)'),
    ('Artist(uri="tidal:artist:login", name=self.msg)',
     'Artist(uri=self.url, name=self.msg)'),
    ('Album(uri="tidal:album:login", name=self.msg)',
     'Album(uri=self.url, name=self.msg)'),
    ('Ref.playlist(\n                name=self.msg,\n                uri="tidal:playlist:login",\n            )',
     'Ref.playlist(\n                name=self.msg,\n                uri=self.url,\n            )'),
    ('Playlist(\n                uri="tidal:playlist:login",',
     'Playlist(\n                uri=self.url,'),
    ('Ref(\n                name=self.msg,\n                type=self.ref_type(),\n                uri=self.uri,\n            )',
     'Ref(\n                name=self.msg,\n                type=self.ref_type(),\n                uri=self.url,\n            )'),
    ('return self.uri if self.uri else f"tidal:{self.schema}:login"',
     'return self.url'),
]
for old, new in pairs:
    assert old in s, f"pattern not found: {old[:60]}"
    s = s.replace(old, new)
p.write_text(s)
print(f"[patch] login_hack uris -> login url ({p})")
