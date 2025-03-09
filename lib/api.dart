import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favorites/models/Video.dart';

const apiKey = "AIzaSyDs-z2Zo8sim-k8LA6-fiywU0seMsiuaFc";

class Api {
  String? _search;
  String? _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=10"));

    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10&pageToken=$_nextToken"));

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<Video> videos = decoded["items"].map<Video>((video) {
        return Video.fromJson(video);
      }).toList();
      return videos;
    } else {
      throw Exception("Failed to load videos.");
    }
  }
}
