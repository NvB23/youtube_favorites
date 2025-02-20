import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/bloc/videos_bloc.dart';
import 'package:youtube_favorites/delegate/data_search.dart';
import 'package:youtube_favorites/widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return VideoTile(video: snapshot.data![index]);
              },
              itemCount: snapshot.data?.length,
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
