// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List>(
        future: sugestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]),
                  leading: const Icon(Icons.search),
                  onTap: () {
                    close(context, snapshot.data?[index]);
                  },
                );
              },
              itemCount: snapshot.data?.length,
            );
          }
        },
      );
    }
  }

  Future<List> sugestions(String search) async {
    http.Response response = await http.get(Uri.parse(
        "https://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=$search"));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body)[1]);
    } else {
      throw Exception("Failed to load suggestions.");
    }
  }
}
