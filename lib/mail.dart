//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';

class Mail extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text('AA Komik!'),
        ),
        body: new MailScreen());
  }
}

class MailScreen extends StatefulWidget {
  @override
  _MailScreen createState() => new _MailScreen();
}

class _MailScreen extends State<MailScreen> {
  final controllerForJokeHeader = new TextEditingController();
  final controllerForJokeText = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controllerForJokeHeader.dispose();
    controllerForJokeText.dispose();
    super.dispose();
  }

  void onPressed(String jokeHeader, String jokeText) {
    print('Mail button is pressed');
    if (jokeHeader != '' && jokeText != '') {
      sendMail(jokeHeader, jokeText);
      controllerForJokeHeader.clear();
      controllerForJokeText.clear();
      mailSentDialog(context); // mail send dialog appear.
    } else {
      print('Fıkra başlığı ya da içeriği boş olamaz');
      noHeaderOrTextDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 45,
          ),
          child: new Text(
            'Başlık',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 45,
          ),
          child: new TextField(
            controller: controllerForJokeHeader,
            textAlign: TextAlign.center,
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 45,
          ),
          child: new Text(
            'Fıkra',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 45,
          ),
          child: new TextField(
            controller: controllerForJokeText,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textAlign: TextAlign.center,
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 45,
          ),
          child: new RaisedButton(
            onPressed: () => onPressed(
                controllerForJokeHeader.text, controllerForJokeText.text),
            child: new Text('Gönder',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
          ),
        )
      ],
    );
  }
}

bool sendMail(String jokeHeader, String jokeText) {
  // If you want to use an arbitrary SMTP server, go with `new SmtpOptions()`.
  // This class below is just for convenience. There are more similar classes available.
  var options = new GmailSmtpOptions()
    ..username = 'se380aakomik@gmail.com' // like anil@gmail.com
    ..password =
        '123456aa!'; // Note: if you have Google's "app specific passwords" enabled,
  // you need to use one of those here.

  // How you use and store passwords is up to you. Beware of storing passwords in plain.

  // Create our email transport.
  var emailTransport = new SmtpTransport(options);

  // Create our mail/envelope.
  var envelope = new Envelope()
    ..from = 'se380aakomik@gmail.com'
    ..recipients.add('se380aakomik@gmail.com')
    //..bccRecipients.add('hidden@recipient.com')
    ..subject = 'AA Komik! Yeni Fıkra.'
    //..text = jokeHeader + jokeText
    ..html = '<h1>' + jokeHeader + '</h1><p>' + jokeText + '</p>';

  bool isSent = false;
  // Email it.
  emailTransport.send(envelope).then((envelope) {
    print('Email sent!');
    isSent = true;
  }).catchError((e) {
    print('Error occurred: $e');
  });
  return isSent;
  //todo: note: it always returns false, it should be fixed.
}

/*Future<Null> noHeaderOrTextDialog(BuildContext context) async {
  return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      child: new AlertDialog(
        title: new Text(
          'UYARI!',
          textAlign: TextAlign.center,
        ),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(
                'Fıkra başlığı ya da içeriği boş bırakılamaz.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new Container(
            //alignment: Alignment.center,
            child: new FlatButton(
              child: new Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ));
}*/

void noHeaderOrTextDialog(BuildContext context) {
  AlertDialog dialog = new AlertDialog(
    content: new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(
                'UYARI!',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            new Container(
              child: new Text(
                'Fıkra başlığı ya da içeriği boş bırakılamaz.',
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              child: new FlatButton(
                color: Colors.grey,
                child: new Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(context: context, child: dialog);
}

void mailSentDialog(BuildContext context) {
  AlertDialog dialog = new AlertDialog(
    content: new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(
                'UYARI!',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            new Container(
              child: new Text(
                'Mail gönderme başarılı(büyük ihtimalle)!',
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              child: new FlatButton(
                color: Colors.grey,
                child: new Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(context: context, child: dialog);
}

void mailNotSentDialog(BuildContext context) {
  AlertDialog dialog = new AlertDialog(
    content: new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(
                'UYARI!',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            new Container(
              child: new Text(
                'Mail gönderme başarılı olmadı, lütfen tekrar deneyiniz.',
                textAlign: TextAlign.center,
              ),
            ),
            new Container(
              child: new FlatButton(
                color: Colors.grey,
                child: new Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
  showDialog(context: context, child: dialog);
}
