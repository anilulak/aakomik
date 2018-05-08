import 'package:flutter/material.dart';
import 'package:aakomik/favouriteslist/favourite_list_item.dart';
import 'package:aakomik/favouriteslist/modal/favourite.dart';

class FavouritesList extends StatelessWidget {
  final List<FavouriteModal> _favouriteModal;

  FavouritesList(this._favouriteModal);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      children: _buildFavouritesList(),
    );
  }

  List<FavouriteListItem> _buildFavouritesList() {
    return _favouriteModal
        .map((favourite) => new FavouriteListItem(favourite))
        .toList();
  }
}