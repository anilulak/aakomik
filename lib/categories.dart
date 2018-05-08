import 'package:flutter/material.dart';
import 'package:aakomik/categorieslist/category_list.dart';
import 'package:aakomik/categorieslist/modal/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('categories').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Text('Loading...');
          }
          return new CategoriesPage(
            categoryModal:
                snapshot.data.documents.map((DocumentSnapshot document) {
              return new CategoryModal(
                  categoryId: int.parse(document['id'].toString()),
                  categoryName: document['name'].toString());
            }).toList(),
          );
        },
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  final List<CategoryModal> categoryModal;

  CategoriesPage({this.categoryModal});

  _buildCategoriesList() {
    return categoryModal;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new CategoriesList(_buildCategoriesList()));
  }
}

/*class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new List(),
        ],
      ),
    );
  }
}

class List extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _List();
  }
}

class _List extends State<List> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue,
      padding: new EdgeInsets.all(5.0),
      child: new ListView(
        children: <Widget>[
          new ListTile(
            // leading: new Icon(Icons.map),
            title: new Text('Laz Fıkraları'),
          ),
          new ListTile(
            title: new Text('Öğrenci- Öğretmen Fıkraları'),
          ),
          new ListTile(
            title: new Text('Programmer Fıkraları'),
            //onTap: _GetRandomFromSelectedCategory("ProgrammerJokes"),
          )
        ],
      ),
    );
  }

  void _GetRandomFromSelectedCategory() {}
}*/
