import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aakomik/randomjoke.dart';
import 'dart:math';
import 'package:share/share.dart';

class SelectedJoke extends StatelessWidget {
  // This widget is the root of your application.
  final String category_id;
  final String joke_id;

  String jokeHeaderForShare;
  String jokeTextForShare;

  SelectedJoke({this.category_id,this.joke_id});

  @override
  Widget build(BuildContext context) {
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

              jokeHeaderForShare = snapshot
                  .data.documents[int.parse(joke_id)].data['title']
                  .toString();
              jokeTextForShare = snapshot
                  .data.documents[int.parse(joke_id)].data['text']
                  .toString();

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
                                iconData: Icons.share,
                                jokeHeaderForShare: jokeHeaderForShare,
                                jokeTextForShare: jokeTextForShare,
                              ),
                          ),
                          new Expanded(
                            child: new JokeMenuButton(
                              id: 2,
                              text: 'Rastgele',
                              iconData: Icons.shuffle,
                              jokeHeaderForShare: jokeHeaderForShare,
                              jokeTextForShare: jokeTextForShare,
                            ),
                          ),
                          new Expanded(
                            child: new JokeMenuButton(
                              id: 3,
                              text: 'Favori Ekle',
                              iconData: Icons.favorite_border,
                              jokeHeaderForShare: jokeHeaderForShare,
                              jokeTextForShare: jokeTextForShare,
                            ),)
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
    this.jokeHeaderForShare,
    this.jokeTextForShare,
  });

  int id;
  String text;
  IconData iconData;
  String jokeHeaderForShare;
  String jokeTextForShare;

  void onPressed(BuildContext context) {
    if (this.id == 1) {
      final RenderBox box = context.findRenderObject();
      Share.share(jokeHeaderForShare + "\n" + jokeTextForShare,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
    else if (this.id == 2) {
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