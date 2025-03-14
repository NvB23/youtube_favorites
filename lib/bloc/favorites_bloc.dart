import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_favorites/models/Video.dart';

class FavoritesBloc extends ChangeNotifier implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoritesBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        final fav = prefs.getString("favorites");
        if (fav != null) {
          _favorites = json.decode(fav).map((k, v) {
            return MapEntry(k, Video.fromJson(v));
          }).cast<String, Video>();

          _favController.sink.add(_favorites);
        }
      }
    });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);
    _save();
  }

  void _save() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
