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

func newJSPF*(playlist: JSPFPlaylist): JSPF =
  result = JSPF(playlist: playlist)

func newJSPFPlaylist*(
    track: seq[JSPFTrack],
    extension: Option[PlaylistExtension] = none(PlaylistExtension),
    date, license, identifier, location: Option[string] = none(string),
    meta, attribution, link: Option[seq[JSPFAttributes]] = none(seq[JSPFAttributes])): JSPFPlaylist =
  result = JSPFPlaylist(
    extension: extension,
    track: track,
    date: date,
    license: license,
    meta: meta,
    attribution: attribution,
    link: link,
    identifier: identifier,
    location: location
  )

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

func newJSPFAttributes*(rel, content: string): JSPFAttributes =
  result = JSPFAttributes(rel: rel, content: content)

func newPlaylistExtension*(playlistExtensionUrl: PlaylistExtensionObject): PlaylistExtension =
  result = PlaylistExtension(playlistExtensionUrl: playlistExtensionUrl)

func newPlaylistExtensionObject*(
  creator, createdFor, public: string,
  collaborators: seq[string],
  copiedFrom, lastModifiedAt: Option[string] = none(string),
  copiedFromDeleted: Option[bool] = none(bool)): PlaylistExtensionObject =
  result = PlaylistExtensionObject(
    creator: creator,
    createdFor: createdFor,
    collaborators: collaborators,
    copiedFrom: copiedFrom,
    lastModifiedAt: lastModifiedAt,
    copiedFromDeleted: copiedFromDeleted,
    public: public
  )

func newTrackExtension*(trackExtensionUrl: TrackExtensionObject): TrackExtension =
  result = TrackExtension(trackExtensionUrl: trackExtensionUrl)

func newTrackExtensionObject*(
  releaseIdentifier: string,
  artistMbids: seq[string],
  addedBy, addedAt: Option[string] = none(string)): TrackExtensionObject =
  result = TrackExtensionObject(
    releaseIdentifier: releaseIdentifier,
    addedBy: addedBy,
    addedAt: addedAt,
    artistMbids: artistMbids
  )
