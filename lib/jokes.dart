import 'package:flutter/material.dart';
import 'package:aakomik/jokeslist/joke_list.dart';
import 'package:aakomik/jokeslist/modal/joke.dart';

class Jokes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new JokesPage(),
    );
  }
}

class JokesPage extends StatelessWidget {
  _buildJokesList() {
    return <JokeModal>[
      const JokeModal(
          categoryId: 1, jokeId: 1, jokeHeader: 'Öldüğünde Öğreniriz', jokeText: 'Ne kadar da komik bir genel fıkra.'),
      const JokeModal(
          categoryId: 1, jokeId: 2, jokeHeader: 'Kuşluğu Beş Geçir', jokeText: 'Ne kadar da komik bir genel fıkra2.'),
      const JokeModal(
          categoryId: 1, jokeId: 3, jokeHeader: 'Papağanın İtirazı', jokeText: 'Ne kadar da komik bir genel fıkra3.'),
      const JokeModal(
          categoryId: 1, jokeId: 4, jokeHeader: 'Temel Askerde', jokeText: 'Ne kadar da komik bir genel fıkra4.'),
      const JokeModal(
          categoryId: 1, jokeId: 5, jokeHeader: 'Neden 6-0?', jokeText: 'Ne kadar da komik bir genel fıkra5.'),
      const JokeModal(
          categoryId: 1, jokeId: 6, jokeHeader: 'Acı Değil', jokeText: 'Ne kadar da komik bir genel fıkra6.'),
      const JokeModal(
          categoryId: 1, jokeId: 7, jokeHeader: 'Sağa Vur', jokeText: 'Ne kadar da komik bir genel fıkra7.'),
      const JokeModal(
          categoryId: 1, jokeId: 8, jokeHeader: '5 Atarız', jokeText: 'Ne kadar da komik bir genel fıkra8.'),
      const JokeModal(
          categoryId: 1, jokeId: 9, jokeHeader: 'Oğlum Bülent Ben Arif', jokeText: 'Ne kadar da komik bir genel fıkra9.'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new JokesList(_buildJokesList()));
  }
}