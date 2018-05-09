import 'package:flutter/material.dart';
import 'package:aakomik/categorieslist/modal/category.dart';
import 'package:aakomik/jokes.dart';
class CategoryListItem extends StatelessWidget {
  final CategoryModal _categoryModal;

  CategoryListItem(this._categoryModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          print('hello');
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new Jokes(category_id:"1"),   //category id same with db, joke id is db-1 since it becomes a list when it gets snapshotted.
              )                                                     //todo: give index as a category_id
          );
        },
        leading: new CircleAvatar(
            child: new Text(_categoryModal.categoryId.toString())),
        title: new Text(_categoryModal.categoryId.toString()),
        subtitle: new Text(_categoryModal.categoryName));
  }
}