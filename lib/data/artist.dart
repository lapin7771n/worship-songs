import 'package:flutter/foundation.dart';

class Artist {
  int uuid;
  String imageUrl;
  final String title;
  final String description;
  final DateTime dateCreated;
  final DateTime dateEdited;

  Artist({
    this.uuid,
    @required this.title,
    this.imageUrl,
    this.description,
    this.dateCreated,
    this.dateEdited,
  });

  Artist.fromMap(Map<String, dynamic> data)
      : uuid = data['id'],
        imageUrl = data['imageUrl'],
        title = data['title'],
        description = data['description'],
        dateCreated = DateTime.parse(data['creationDate']),
        dateEdited = DateTime.parse(data['lastEditDate']);

  @override
  String toString() {
    return 'Artist{uuid: $uuid, title: $title, imageUrl: $imageUrl, description: $description, dateCreated: $dateCreated, dateEdited: $dateEdited}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Artist &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          description == other.description &&
          dateCreated == other.dateCreated &&
          dateEdited == other.dateEdited;

  @override
  int get hashCode =>
      uuid.hashCode ^
      imageUrl.hashCode ^
      title.hashCode ^
      description.hashCode ^
      dateCreated.hashCode ^
      dateEdited.hashCode;
}
