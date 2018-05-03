import 'package:flutter/material.dart';

class Joke extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('AA Komik!'),
        ),
        body: new Container(
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
                            id: 1, text: 'Paylaş', iconData: Icons.share)),
                    new Expanded(
                        child: new JokeMenuButton(
                            id: 2, text: 'Rastgele', iconData: Icons.shuffle)),
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
                        'Pilot Temel',
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Text(
                        'Pilot Temel var gücüyle bağırıyordu:'
                            '"Ula sağ motor bozuldu. Düşeyrum, düşeyrum. Meydey düşeyrum. Kule düşeyrum."'
                            'Kule hemen cevapladı:'
                            '- "Mesaj anlaşıldı. Yerinizi bildirin, yerinizi bildirin.'
                            'Temel gayet ciddi:'
                            '-"Pilot kabini, öndeki sol koltuk, pilot kabini, öndeki sol koltuk."',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
            ],
          ),
        ));
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
      Navigator.of(context).pushNamed("/Joke");
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
