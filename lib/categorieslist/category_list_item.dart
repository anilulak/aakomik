import 'package:flutter/material.dart';
import 'package:aakomik/categorieslist/modal/category.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryModal _categoryModal;

  CategoryListItem(this._categoryModal);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap: () {
          print('hello');
          Navigator.of(context).pushNamed("/Jokes");
        },
        leading: new CircleAvatar(
            child: new Text(_categoryModal.categoryId.toString())),
        title: new Text(_categoryModal.categoryId.toString()),
        subtitle: new Text(_categoryModal.categoryName));
  }
}