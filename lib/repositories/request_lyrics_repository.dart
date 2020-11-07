import 'dart:convert';

import 'package:worshipsongs/data/content_requests/requested_song.dart';
import 'package:worshipsongs/providers/base_provider.dart';
import 'package:worshipsongs/repositories/crudMixin.dart';

class RequestSongsRepository extends BaseProvider
    implements Crud<RequestedSong> {
  static const String _ENDPOINT_URL = "/requested-songs";
  static const String _REQUEST_ID_KEY = "requestId";

  final String accessToken;

  RequestSongsRepository(this.accessToken);

  @override
  Future<RequestedSong> createEntity(RequestedSong requestedSong) async {
    final String url = "$API_URL$_ENDPOINT_URL";
    final response =
        await put(url, accessToken, requestedSongToJson(requestedSong));
    if (response.statusCode != 200) {
      throw Exception(
        "Error creating artist request: ${jsonDecode(response.body)}",
      );
    }

    return requestedSongFromJson(response.body);
  }

  @override
  Future<RequestedSong> deleteEntity(RequestedSong requestedSong) async {
    final String url =
        "$API_URL$_ENDPOINT_URL?$_REQUEST_ID_KEY=${requestedSong.id}";
    final response = await delete(url, accessToken);
    if (response.statusCode != 200) {
      throw Exception(
        "Error deleting artist request: ${jsonDecode(response.body)}",
      );
    }

    return requestedSong;
  }

  @override
  Future<List<RequestedSong>> readEntities() async {
    final String url = "$API_URL$_ENDPOINT_URL";
    final response = await get(url, accessToken);
    if (response.statusCode != 200) {
      throw Exception(
        "Error deleting artist request: ${jsonDecode(response.body)}",
      );
    }

    return (jsonDecode(response.body) as List)
        .map((e) => requestedSongFromJson(e))
        .toList();
  }

  @override
  Future<RequestedSong> updateEntity(RequestedSong requestedSong) {
    return createEntity(requestedSong);
  }
}
