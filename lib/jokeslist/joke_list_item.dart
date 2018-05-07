import 'package:flutter/material.dart';
import 'package:aakomik/jokeslist/modal/joke.dart';

class JokeListItem extends StatelessWidget {
  final JokeModal _jokeModal;

  JokeListItem(this._jokeModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: new CircleAvatar(child: new Text(_jokeModal.categoryId.toString())),
        title: new Text(_jokeModal.jokeId.toString()),
        subtitle: new Text(_jokeModal.jokeHeader));
  }
}