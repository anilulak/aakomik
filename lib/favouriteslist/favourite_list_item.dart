import 'dart:async';
import 'dart:io';

import 'package:aakomik/selectedjoke.dart';
import 'package:flutter/material.dart';
import 'package:aakomik/favouriteslist/modal/favourite.dart';
import 'package:path_provider/path_provider.dart';

class FavouriteListItem extends StatelessWidget {
  final FavouriteModal _favouriteModal;

  FavouriteListItem(this._favouriteModal);

  Future<String> get _localPathForFavourites async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileForFavourites async {
    final path = await _localPathForFavourites;

    return new File('$path/favourites.txt');
  }

  Future<File> writeRestFavourites(String text) async {
    final file = await _localFileForFavourites;

    // Write the file
    return file.writeAsString('$text', mode: FileMode.WRITE);
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



  @override
  Widget build(BuildContext context) {



    return new ListTile(
        onTap: () {
          print('fikra will be opened');
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new SelectedJoke(
                category_id: _favouriteModal.categoryId.toString(),
                joke_id: _favouriteModal.jokeId.toString(),
              ),
            ),
          );
        },
        leading: new IconButton(
          icon: new Icon(Icons.favorite),
          onPressed: () {
            print('favhello: it will ask fikra will be dropped from favslist.');
          },
        ),
        title: new Text(_favouriteModal.jokeHeader),
        //subtitle: new Text(_favouriteModal.jokeText)
    );
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