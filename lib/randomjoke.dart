import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:share/share.dart';

class RandomJoke extends StatelessWidget {
  // This widget is the root of your application.
  String category_id;
  String joke_id;

  String jokeHeaderForShare;
  String jokeTextForShare;

  String generateRandomCategoryId() {
    var randomGenerator = new Random();
    int randomCategoryNumber = randomGenerator.nextInt(9) + 1;
    return randomCategoryNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    category_id = generateRandomCategoryId();
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('AA Komik!'),
        ),
        body: new StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(category_id).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');
              final int numberOfJokes = snapshot.data.documents.length;
              var randomGenerator = new Random();
              int randomJokeNumber = randomGenerator.nextInt(numberOfJokes);

              joke_id = randomJokeNumber.toString();

              jokeHeaderForShare = snapshot
                  .data.documents[int.parse(joke_id)].data['title']
                  .toString();
              jokeTextForShare = snapshot
                  .data.documents[int.parse(joke_id)].data['text']
                  .toString();

              return new Container(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: new JokeMenuButton(
                              id: 1,
                              text: 'Paylaş',
                              iconData: Icons.share,
                              jokeHeaderForShare: jokeHeaderForShare,
                              jokeTextForShare: jokeTextForShare,
                              categoryId: category_id,
                              jokeId: joke_id,
                            ),
                          ),
                          new Expanded(
                            child: new JokeMenuButton(
                              id: 2,
                              text: 'Rastgele',
                              iconData: Icons.shuffle,
                              jokeHeaderForShare: jokeHeaderForShare,
                              jokeTextForShare: jokeTextForShare,
                              categoryId: category_id,
                              jokeId: joke_id,
                            ),
                          ),
                          new Expanded(
                            child: new JokeMenuButton(
                              id: 3,
                              text: 'Favorile',
                              iconData: Icons.favorite_border,
                              jokeHeaderForShare: jokeHeaderForShare,
                              jokeTextForShare: jokeTextForShare,
                              categoryId: category_id,
                              jokeId: joke_id,
                            ),
                          )
                        ],
                      ),
                    ),
                    new Container(
                        alignment: Alignment.topCenter,
                        padding: new EdgeInsets.only(
                          top: 10.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: new Column(
                          children: <Widget>[
                            new Text(
                              snapshot.data.documents[int.parse(joke_id)]
                                  .data['title']
                                  .toString(),
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text(
                              snapshot.data.documents[int.parse(joke_id)]
                                  .data['text']
                                  .toString(),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ))
                  ],
                ),
              );
            }));
  }
}

class JokeMenuButton extends StatelessWidget {
  JokeMenuButton({
    this.id,
    this.text,
    this.iconData,
    this.jokeHeaderForShare,
    this.jokeTextForShare,
    this.categoryId,
    this.jokeId,
  });

  int id;
  String text;
  IconData iconData;
  String jokeHeaderForShare;
  String jokeTextForShare;
  String categoryId;
  String jokeId;

  Future<String> get _localPathForFavourites async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileForFavourites async {
    final path = await _localPathForFavourites;

    return new File('$path/favourites.txt');
  }

  Future<File> writeOneFavourite(
      String category_id, String joke_id, String title, String text) async {
    final file = await _localFileForFavourites;

    String favouriteJoke =
        category_id + "*" + joke_id + "*" + title + "*" + text + "#";

    // Write the file
    return file.writeAsString('$favouriteJoke', mode: FileMode.APPEND);
  }

  void onPressed(BuildContext context) {
    if (this.id == 1) {
      final RenderBox box = context.findRenderObject();
      Share.share(jokeHeaderForShare + "\n" + jokeTextForShare,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else if (this.id == 2) {
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new RandomJoke(),
          ));
    } else if (this.id == 3) {
      writeOneFavourite(
          categoryId, jokeId, jokeHeaderForShare, jokeTextForShare);
    }
  }

  // This widget is the buttons of menu(on the main screen).
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new RaisedButton(
        color: Colors.deepOrangeAccent,
        onPressed: () => onPressed(context),
        child: new Container(
          child: new Row(
            children: <Widget>[
              new Container(child: new Icon(iconData)),
              new Container(
                  padding: new EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 45,
                  ),
                  child: new Text(text)),
            ],
          ),
        ),
      ),
    );
  }
}
