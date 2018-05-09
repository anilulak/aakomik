import 'package:flutter/material.dart';
import 'package:aakomik/jokeslist/joke_list.dart';
import 'package:aakomik/jokeslist/modal/joke.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aakomik/categorieslist/modal/category.dart';

class Jokes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('2').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Text('Loading...');
          }
          return new JokesPage(
            jokeModal: snapshot.data.documents.map((DocumentSnapshot document) {
              return new JokeModal(
                categoryId: int.parse(document['category_id'].toString()),
                jokeId: int.parse(document['joke_id'].toString()),
                jokeHeader: document['title'].toString(),
                jokeText: document['text'].toString(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class JokesPage extends StatelessWidget {
  CategoryModal categoryModal;
  final List<JokeModal> jokeModal;

  JokesPage({this.categoryModal, this.jokeModal});

  _buildJokesList() {
    return jokeModal;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new JokesList(_buildJokesList()));
  }
}