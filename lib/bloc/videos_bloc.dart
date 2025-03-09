// ignore_for_file: file_names

import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/api.dart';
import 'package:youtube_favorites/models/Video.dart';

class VideosBloc extends ChangeNotifier implements BlocBase {
  final Api api = Api();
  List<Video> videos = [];

  final StreamController<List<Video>?> _videoController =
      StreamController.broadcast();
  Stream<List<Video>?> get outVideos => _videoController.stream;

  final StreamController<String?> _searchController =
      StreamController<String?>();
  Sink<String?> get inSearch => _searchController.sink;

  VideosBloc() {
    _searchController.stream.listen(_search);
  }

  void _search(String? search) async {
    if (search != null) {
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videoController.sink.add(videos);
    notifyListeners();
  }

  @override
  void dispose() {
    _videoController.close();
    _searchController.close();
    super.dispose();
  }
}
