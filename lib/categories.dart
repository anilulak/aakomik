import 'package:flutter/material.dart';
import 'package:aakomik/categorieslist/category_list.dart';
import 'package:aakomik/categorieslist/modal/category.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new CategoriesPage(),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  _buildCategoriesList() {
    return <CategoryModal>[
      const CategoryModal(
          categoryId: 1, categoryName: 'Genel Fıkralar'),
      const CategoryModal(
          categoryId: 2, categoryName: 'Karadeniz Fıkraları'),
      const CategoryModal(
          categoryId: 3, categoryName: 'Nasreddin Hoca Fıkraları'),
      const CategoryModal(
          categoryId: 4, categoryName: 'Okul Fıkraları'),
      const CategoryModal(
          categoryId: 5, categoryName: 'Temel Fıkraları'),
      const CategoryModal(
          categoryId: 6, categoryName: 'Kayserili Fıkraları'),
      const CategoryModal(
          categoryId: 7, categoryName: 'Deli Fıkraları'),
      const CategoryModal(
          categoryId: 8, categoryName: 'Erzurum Fıkraları'),
      const CategoryModal(
          categoryId: 9, categoryName: 'Asker Fıkraları'),
    ];
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
