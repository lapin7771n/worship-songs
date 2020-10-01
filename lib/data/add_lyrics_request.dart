class AddLyricsRequest {
  int uuid;
  String title;
  String text;
  int authorID;
  int albumID;
  int requestedBy;
  DateTime timestamp;

  AddLyricsRequest({
    this.uuid,
    this.title,
    this.text,
    this.authorID,
    this.albumID,
    this.requestedBy,
    this.timestamp,
  });

  AddLyricsRequest.empty()
      : uuid = null,
        title = "",
        text = "",
        authorID = null,
        albumID = null,
        requestedBy = null,
        timestamp = null;
}
