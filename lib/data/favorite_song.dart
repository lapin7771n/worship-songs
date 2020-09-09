class FavoriteSong {
  final int userId;
  final int songId;
  final int id;

  FavoriteSong({
    this.id,
    this.songId,
    this.userId,
  });

  FavoriteSong.fromMap(Map<String, dynamic> data)
      : userId = data["userId"],
        songId = data["songId"],
        id = data["id"];
}
