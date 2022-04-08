# jspf-nim

Support for the JSPF playlist format in Nim.

Playlist and track extensions are supported, `JSPFPlaylist` and `JSPFTrack` are `ref object of RootObj` and thus can be inherited by your own `Playlist` or `Track` object with extensions.

---

Example playlist and track extension definitions:

```
type
  Playlist* = ref object of JSPFPlaylist
    extension*: Option[PlaylistExtension]

  PlaylistExtension* = ref object
    playlistExtensionUrl*: MusicBrainzPlaylistExtension

  MusicBrainzPlaylistExtension* = ref object
    creator*, createdFor*: string
    collaborators*: seq[string]
    copiedFrom*, lastModifiedAt*: Option[string]
    copiedFromDeleted*: Option[bool]
    public*: string

  Track* = ref object of JSPFTrack
    extension*: TrackExtension

  TrackExtension* = ref object
    trackExtensionUrl*: MusicBrainzTrackExtension

  MusicBrainzTrackExtension* = ref object
    releaseIdentifier*: string
    addedBy*, addedAt*: Option[string]
    artistMbids*: seq[string]
```
https://gitlab.com/tandy1000/listenbrainz-nim/-/blob/master/src/listenbrainz/utils/jspf.nim#L9


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
