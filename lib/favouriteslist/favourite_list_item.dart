import 'package:flutter/material.dart';
import 'package:aakomik/favouriteslist/modal/favourite.dart';

class FavouriteListItem extends StatelessWidget {
  final FavouriteModal _favouriteModal;

  FavouriteListItem(this._favouriteModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          print('fikra will be opened');
          Navigator.of(context).pushNamed("/Joke");
        },
        leading: new IconButton(
          icon: new Icon(Icons.favorite),
          onPressed: () {
            print('favhello: it will ask fikra will be dropped from favslist.');
          },
        ),
        title: new Text(_favouriteModal.jokeHeader),
        subtitle: new Text(_favouriteModal.jokeText));
  }
}
