// To parse this JSON data, do
//
//     final requestedSong = requestedSongFromJson(jsonString);

import 'dart:convert';

RequestedSong requestedSongFromJson(String str) =>
    RequestedSong.fromJson(json.decode(str));

String requestedSongToJson(RequestedSong data) => json.encode(data.toJson());

class RequestedSong {
  RequestedSong({
    this.title,
    this.text,
    this.artistId,
    this.language,
    this.albumId,
    this.requestedBy,
    this.requestDate,
    this.id,
  });

  String title;
  String text;
  int artistId;
  String language;
  int albumId;
  int requestedBy;
  DateTime requestDate;
  int id;

  RequestedSong copyWith({
    String title,
    String text,
    int artistId,
    String language,
    int albumId,
    int requestedBy,
    DateTime requestDate,
    int id,
  }) =>
      RequestedSong(
        title: title ?? this.title,
        text: text ?? this.text,
        artistId: artistId ?? this.artistId,
        language: language ?? this.language,
        albumId: albumId ?? this.albumId,
        requestedBy: requestedBy ?? this.requestedBy,
        requestDate: requestDate ?? this.requestDate,
        id: id ?? this.id,
      );

  factory RequestedSong.fromJson(Map<String, dynamic> json) => RequestedSong(
        title: json["title"],
        text: json["text"],
        artistId: json["artistID"],
        language: json["language"],
        albumId: json["albumID"],
        requestedBy: json["requestedBy"],
        requestDate: DateTime.parse(json["requestDate"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "artistID": artistId,
        "language": language,
        "albumID": albumId,
        "requestedBy": requestedBy,
        "requestDate": requestDate.toIso8601String(),
        "id": id,
      };
}
