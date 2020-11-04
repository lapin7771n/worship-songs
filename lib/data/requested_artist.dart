// To parse this JSON data, do
//
//     final requestedArtist = requestedArtistFromJson(jsonString);

import 'dart:convert';

RequestedArtist requestedArtistFromJson(String str) => RequestedArtist.fromJson(json.decode(str));

String requestedArtistToJson(RequestedArtist data) => json.encode(data.toJson());

class RequestedArtist {
  RequestedArtist({
    this.title,
    this.imageUrl,
    this.description,
    this.requestedBy,
    this.requestDate,
    this.id,
  });

  final String title;
  final String imageUrl;
  final String description;
  final int requestedBy;
  final DateTime requestDate;
  final int id;

  RequestedArtist copyWith({
    String title,
    String imageUrl,
    String description,
    int requestedBy,
    DateTime requestDate,
    int id,
  }) =>
      RequestedArtist(
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        requestedBy: requestedBy ?? this.requestedBy,
        requestDate: requestDate ?? this.requestDate,
        id: id ?? this.id,
      );

  factory RequestedArtist.fromJson(Map<String, dynamic> json) => RequestedArtist(
    title: json["title"],
    imageUrl: json["imageUrl"],
    description: json["description"],
    requestedBy: json["requestedBy"],
    requestDate: DateTime.parse(json["requestDate"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "imageUrl": imageUrl,
    "description": description,
    "requestedBy": requestedBy,
    "requestDate": requestDate.toIso8601String(),
    "id": id,
  };
}
