import 'package:flutter/material.dart';
import 'package:aakomik/jokeslist/joke_list_item.dart';
import 'package:aakomik/jokeslist/modal/joke.dart';

class JokesList extends StatelessWidget {
  final List<JokeModal> _jokeModal;

  JokesList(this._jokeModal);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      children: _buildJokesList(),
    );
  }

  List<JokeListItem> _buildJokesList() {
    return _jokeModal
        .map((joke) => new JokeListItem(joke))
        .toList();
  }
}