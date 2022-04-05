import std/options

type
  JSPFObject* = ref object of RootObj
    title*, creator*, annotation*, info*, image*: Option[string]

  JSPF* = ref object
    playlist*: JSPFPlaylist

  JSPFPlaylist* = ref object of JSPFObject
    extension*: Option[PlaylistExtension]
    track*: seq[JSPFTrack]
    date*, license*: Option[string]
    meta*, attribution*, link*: Option[seq[JSPFAttributes]]
    identifier*, location*: Option[string]

  JSPFTrack* = ref object of JSPFObject
    trackNum*, duration*: Option[int]
    album*: Option[string]
    identifier*, location*: Option[string]
    meta*, link*: Option[JSPFAttributes]
    extension*: TrackExtension

  JSPFAttributes* = ref object
    rel*, content*: string

  PlaylistExtension* = ref object
    playlistExtensionUrl*: PlaylistExtensionObject

  PlaylistExtensionObject* = ref object
    creator*, createdFor*: string
    collaborators*: seq[string]
    copiedFrom*, lastModifiedAt*: Option[string]
    copiedFromDeleted*: Option[bool]
    public*: string

  TrackExtension* = ref object
    trackExtensionUrl*: TrackExtensionObject

  TrackExtensionObject* = ref object
    releaseIdentifier*: string
    addedBy*, addedAt*: Option[string]
    artistMbids*: seq[string]

func newJSPFTrack*(
  title, creator, annotation, info, image, album, identifier, location: Option[string] = none(string),
  trackNum, duration: Option[int] = none(int),
  meta, link: Option[JSPFAttributes] = none(JSPFAttributes)): JSPFTrack =
  result = JSPFTrack(
    title: title,
    creator: creator,
    annotation: annotation,
    info: info,
    image: image,
    album: album,
    trackNum: trackNum,
    duration: duration,
    identifier: identifier,
    location: location,
    meta: meta,
    link: link
  )
