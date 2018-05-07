import 'package:flutter/material.dart';
import 'package:aakomik/categorieslist/category_list_item.dart';
import 'package:aakomik/categorieslist/modal/category.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoryModal> _categoryModal;

  CategoriesList(this._categoryModal);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      children: _buildCategoriesList(),
    );
  }

  List<CategoryListItem> _buildCategoriesList() {
    return _categoryModal
        .map((category) => new CategoryListItem(category))
        .toList();
  }
}