import 'package:flutter/material.dart';
import 'package:aakomik/jokeslist/modal/joke.dart';

class JokeListItem extends StatelessWidget {
  final JokeModal _jokeModal;

  JokeListItem(this._jokeModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          print('hello from joke_list_item');
          Navigator.of(context).pushNamed("/Joke");
        },
        leading: new CircleAvatar(child: new Text(_jokeModal.categoryId.toString())),
        title: new Text(_jokeModal.jokeId.toString()),
        subtitle: new Text(_jokeModal.jokeHeader));
  }
}