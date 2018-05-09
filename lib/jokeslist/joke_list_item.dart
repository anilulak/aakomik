import 'package:flutter/material.dart';
import 'package:aakomik/jokeslist/modal/joke.dart';
import 'package:aakomik/selectedjoke.dart';

class JokeListItem extends StatelessWidget {
  final JokeModal _jokeModal;

  JokeListItem(this._jokeModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new SelectedJoke(
                    category_id: _jokeModal.categoryId.toString(),
                    joke_id: (_jokeModal.jokeId - 1).toString(),
                  ), //category id same with db, joke id is db-1 since it becomes a list when it gets snapshotted.
            ), //todo: give index as a category_id
          );
        },
        leading:
            new CircleAvatar(child: new Text(_jokeModal.categoryId.toString())),
        title: new Text(_jokeModal.jokeId.toString()),
        subtitle: new Text(_jokeModal.jokeHeader));
  }
}
