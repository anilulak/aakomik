import 'package:flutter/material.dart';
import 'randomjoke.dart';
import 'categories.dart';
import 'notification_option.dart';
import 'jokes.dart';
import 'favourites.dart';
import 'mail.dart';
import 'selectedjoke.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      "/Joke": (BuildContext context) => new RandomJoke(),
      "/NotificationOption": (BuildContext context) => new NotificationOption(),
      "/Categories": (BuildContext context) => new Categories(),
      "/Jokes": (BuildContext context) => new Jokes(),
      "/Favourites": (BuildContext context) => new Favourites(),
      "/Mail": (BuildContext context) => new Mail(),
      "/SelectedJoke": (BuildContext context) => new SelectedJoke(),
    };
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(title: 'AA Komik!'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Center(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Image(image: new AssetImage('assets/happy_emoji.png')),
                  ]),
            ),
            new MenuButton(
                id: 1, text: 'Rastgele Fıkra', iconData: Icons.shuffle),
            new MenuButton(id: 2, text: 'Kategoriler', iconData: Icons.list),
            new MenuButton(id: 3, text: 'Favoriler', iconData: Icons.favorite),
            new MenuButton(
                id: 4, text: 'Bildirim Ayarı', iconData: Icons.settings),
            new MenuButton(id: 5, text: 'Fıkra Gönder', iconData: Icons.mail),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({
    this.id,
    this.text,
    this.iconData,
  });

  int id;
  String text;
  IconData iconData;

  void onPressed(BuildContext context) {
    if (this.id == 1) {
      Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new RandomJoke(),
          ));
    } else if (this.id == 2) {
      Navigator.of(context).pushNamed("/Categories");
    } else if (this.id == 3) {
      Navigator.of(context).pushNamed("/Favourites");
    } else if (this.id == 4) {
      Navigator.of(context).pushNamed("/NotificationOption");
    } else if (this.id == 5) {
      Navigator.of(context).pushNamed("/Mail");
    }
  }

  // This widget is the buttons of menu(on the main screen).
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new RaisedButton(
        color: Colors.orange,
        onPressed: () => onPressed(context),
        child: new Container(
          width: MediaQuery.of(context).size.width / 2,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(child: new Icon(iconData)),
              new Container(
                padding: new EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 45,
                ),
                alignment: Alignment.topRight,
                child: new Text(
                  text,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
