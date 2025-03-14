import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/bloc/favorites_bloc.dart';
import 'package:youtube_favorites/models/Video.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoritesBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favoritos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        initialData: const {},
        builder: (context, snapshot) {
          return ListView(
              children: snapshot.data!.values.map(
            (v) {
              return InkWell(
                onTap: () {},
                onLongPress: () {
                  bloc.toggleFavorite(v);
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 70,
                      child: Image.network(v.thumb),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      v.title,
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 2,
                    ))
                  ],
                ),
              );
            },
          ).toList());
        },
      ),
    );
  }
}
