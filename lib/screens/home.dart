import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/bloc/videos_bloc.dart';
import 'package:youtube_favorites/delegate/data_search.dart';
import 'package:youtube_favorites/widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset("images/youtube-logo-1-3.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              "0",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                bloc.inSearch.add(result);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return VideoTile(video: snapshot.data![index]);
                } else {
                  bloc.inSearch.add(null);
                  return Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                }
              },
              itemCount: snapshot.data!.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
