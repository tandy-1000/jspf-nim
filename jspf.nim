import std/options

type
  JSPF* = ref object
    playlist*: JSPFPlaylist

  JSPFPlaylist* = ref object of RootObj
    title*, creator*, annotation*, info*, image*: Option[string]
    # track*: seq[JSPFTrack] ## To enable custom extensions through inheritance, define this yourself.
    date*, license*: Option[string]
    meta*, attribution*, link*: Option[seq[JSPFAttributes]]
    identifier*, location*: Option[string]

  JSPFTrack* = ref object of RootObj
    title*, creator*, annotation*, info*, image*: Option[string]
    trackNum*, duration*: Option[int]
    album*: Option[string]
    identifier*, location*: Option[string]
    meta*, link*: Option[JSPFAttributes]

  JSPFAttributes* = ref object
    rel*, content*: string

func newJSPF*(playlist: JSPFPlaylist): JSPF =
  result = JSPF(playlist: playlist)

func newJSPFPlaylist*(
  # track: seq[JSPFTrack],
  title, creator, annotation, info, image, date, license, identifier, location: Option[string] = none(string),
  meta, attribution, link: Option[seq[JSPFAttributes]] = none(seq[JSPFAttributes])): JSPFPlaylist =
  result = JSPFPlaylist(
    # track: track,
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
