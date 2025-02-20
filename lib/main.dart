import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/bloc/videos_bloc.dart';
import 'package:youtube_favorites/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      dependencies: const [],
      blocs: [
        Bloc(
          (i) => VideosBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Favoritos do Youtube',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
