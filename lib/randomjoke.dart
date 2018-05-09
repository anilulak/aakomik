import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class RandomJoke extends StatelessWidget {
  // This widget is the root of your application.
  String category_id;
  String joke_id;

  String generateRandomCategoryId() {
    var randomGenerator = new Random();
    int randomCategoryNumber = randomGenerator.nextInt(9) + 1;
    return randomCategoryNumber.toString();
  }

  //RandomJoke({this.category_id,this.joke_id});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('AA Komik!'),
        ),
        body: new StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(generateRandomCategoryId()).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');
              final int numberOfJokes = snapshot.data.documents.length;
              var randomGenerator = new Random();
              int randomJokeNumber = randomGenerator.nextInt(numberOfJokes);
              // todo: get a random value out of numberofJokes. assign it to joke_id . Getting joke id from prev screen is not necessary, can changed.
              joke_id = randomJokeNumber.toString();
              return new Container(
                //alignment: Alignment.topCenter,
                //width: MediaQuery.of(context).size.width,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      //alignment: Alignment.topCenter,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                              child: new JokeMenuButton(
                                  id: 1,
                                  text: 'Paylaş',
                                  iconData: Icons.share)),
                          new Expanded(
                              child: new JokeMenuButton(
                                  id: 2,
                                  text: 'Rastgele',
                                  iconData: Icons.shuffle)),
                          new Expanded(
                              child: new JokeMenuButton(
                                  id: 3,
                                  text: 'Favori Ekle',
                                  iconData: Icons.favorite_border))
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
                              snapshot.data.documents[int.parse(joke_id)].data['title']
                                  .toString(),
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text(
                              snapshot.data.documents[int.parse(joke_id)].data['text']
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
  });

  int id;
  String text;
  IconData iconData;

  void onPressed(BuildContext context) {
    if (this.id == 2) {
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new RandomJoke(),   //category id same with db, joke id is db-1 since it becomes a list when it gets snapshotted.
            //category id should be string since it will sent to firestore and that field is kept in string, joke id should be a int , since its a index of a list.
          )                                                               //todo: give these numbers randomly
      );
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
                //width: MediaQuery.of(context).size.width / 3,
                child: new Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(child: new Icon(iconData)),
                new Container(
                    padding: new EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 45,
                    ),
                    //alignment: Alignment.topRight,
                    child: new Text(text)),
              ],
            ))));
  }
}
