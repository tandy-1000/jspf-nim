# jspf-nim

Support for the JSPF playlist format in Nim.

---

Example usage with [jsony](https://github.com/treeform/jsony/):

```
proc renameHook*(v: var PlaylistExtension, fieldName: var string) =
  ## jsony hook to rename incoming playlist extension field
  if fieldName == "https://musicbrainz.org/doc/jspf#playlist":
    fieldName = "playlistExtensionUrl"

proc renameHook*(v: var TrackExtension, fieldName: var string) =
  ## jsony hook to rename incoming track extension field
  if fieldName == "https://musicbrainz.org/doc/jspf#track":
    fieldName = "trackExtensionUrl"

proc dumpHook*(s: var string, v: PlaylistExtension) =
  ## jsony hook to rename outgoing playlist extension field
  s.add '{'
  s.dumpKey("https://musicbrainz.org/doc/jspf#playlist")
  s.dumpHook(v.playlistExtensionUrl)
  s.add '}'

proc dumpHook*(s: var string, v: TrackExtension) =
  ## jsony hook to rename outgoing track extension field
  s.add '{'
  s.dumpKey("https://musicbrainz.org/doc/jspf#track")
  s.dumpHook(v.trackExtensionUrl)
  s.add '}'
```
https://gitlab.com/tandy1000/listenbrainz-nim/-/blob/master/src/listenbrainz/utils/tools.nim#L57
