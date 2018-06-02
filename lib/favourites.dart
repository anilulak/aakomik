import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:aakomik/favouriteslist/favourite_list.dart';
import 'package:aakomik/favouriteslist/modal/favourite.dart';
import 'package:path_provider/path_provider.dart';

class Favourites extends StatelessWidget {
  Storage storage = new Storage();

  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    var futureBuilder = new FutureBuilder(
        future: storage.readFavourites(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('loading...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new FavouritesPage(
                  favouriteModal: createListOfFavouriteModal(context, snapshot),
                );
          }
        });

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: futureBuilder,
    );
  }
}

class FavouritesPage extends StatelessWidget {
  final List<FavouriteModal> favouriteModal;

  FavouritesPage({this.favouriteModal});

  _buildFavouritesList() {
    return favouriteModal;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new FavouritesList(_buildFavouritesList()));
  }
}

// class to read/write file.
class Storage {
  Future<String> get _localPathForFavourites async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileForFavourites async {
    final path = await _localPathForFavourites;

    return new File('$path/favourites.txt');
  }

  Future<File> writeOneFavourite(String category_id, String joke_id, String title, String text) async {
    final file = await _localFileForFavourites;

    String favouriteJoke = category_id + "*" + joke_id + "*" + title + "*" + text + "#";

    // Write the file
    return file.writeAsString('$favouriteJoke', mode: FileMode.APPEND);
  }

  Future<List<String>> readFavourites() async {
    try {
      final file = await _localFileForFavourites;

      // Read the file
      String contents = await file.readAsString();
      print('Contents of read favourites:' + contents);
      return divideJokes(contents);
    } catch (e) {
      // If we encounter an error, return error, this is our default message.
      return divideJokes("");
    }
  }
}

List<String> divideJokes(String text) {
  List<String> jokes = text.trim().split("#");
  return jokes;
}

List<String> divideOneJoke(String text) {
  List<String> jokeElements = text.trim().split("*");
  return jokeElements;
}

List<FavouriteModal> createListOfFavouriteModal(BuildContext context, AsyncSnapshot snapshot) {
  List<FavouriteModal> favs = <FavouriteModal>[

  ];

  try {
    List<String> values = snapshot.data;

    for (int i = 0; i < values.length; i++) {
      int a = int.parse(divideOneJoke(values.elementAt(i)).elementAt(0));
      int b = int.parse(divideOneJoke(values.elementAt(i)).elementAt(1));
      favs.add(FavouriteModal(
        categoryId: a,
        jokeId: b,
        jokeHeader: divideOneJoke(values.elementAt(i)).elementAt(2),
        jokeText: divideOneJoke(values.elementAt(i)).elementAt(3),
      )
      );
    }
  } catch(e) {

    print("createListOfFavouriteModal" + e.toString());
  }
  finally {
    return favs;
  }
}