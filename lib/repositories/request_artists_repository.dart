import 'dart:convert';

import 'package:worshipsongs/data/content_requests/requested_artist.dart';
import 'package:worshipsongs/providers/base_provider.dart';
import 'package:worshipsongs/repositories/crudMixin.dart';

class RequestArtistsRepository extends BaseProvider
    implements Crud<RequestedArtist> {
  static const String _ENDPOINT_URL = "/requested-artists";
  static const String _REQUEST_ID_KEY = "requestId";

  final String accessToken;

  RequestArtistsRepository(this.accessToken);

  @override
  Future<RequestedArtist> createEntity(RequestedArtist artist) async {
    final String url = "$API_URL$_ENDPOINT_URL";
    final response = await put(url, accessToken, requestedArtistToJson(artist));
    if (response.statusCode != 200) {
      throw Exception(
        "Error creating artist request: ${jsonDecode(response.body)}",
      );
    }

    return requestedArtistFromJson(response.body);
  }

  @override
  Future<RequestedArtist> deleteEntity(RequestedArtist artist) async {
    final String url = "$API_URL$_ENDPOINT_URL?$_REQUEST_ID_KEY=${artist.id}";
    final response = await delete(url, accessToken);
    if (response.statusCode != 200) {
      throw Exception(
        "Error deleting artist request: ${jsonDecode(response.body)}",
      );
    }

    return artist;
  }

  @override
  Future<List<RequestedArtist>> readEntities() async {
    final String url = "$API_URL$_ENDPOINT_URL";
    final response = await get(url, accessToken);
    if (response.statusCode != 200) {
      throw Exception(
        "Error deleting artist request: ${jsonDecode(response.body)}",
      );
    }

    return (jsonDecode(response.body) as List)
        .map((e) => requestedArtistFromJson(e))
        .toList();
  }

  @override
  Future<RequestedArtist> updateEntity(RequestedArtist artist) async {
    return createEntity(artist);
  }
}
