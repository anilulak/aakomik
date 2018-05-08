import 'package:flutter/material.dart';
import 'package:aakomik/favouriteslist/favourite_list.dart';
import 'package:aakomik/favouriteslist/modal/favourite.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'AA Komik!';

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new FavouritesPage(),
    );
  }
}

class FavouritesPage extends StatelessWidget {
  _buildFavouritesList() {
    return <FavouriteModal>[
      const FavouriteModal(
          categoryId: 1, jokeId: 1, jokeHeader: 'Öldüğünde Öğreniriz', jokeText: 'Ne kadar da komik bir genel fıkra.'),
      const FavouriteModal(
          categoryId: 1, jokeId: 2, jokeHeader: 'Kuşluğu Beş Geçir', jokeText: 'Ne kadar da komik bir genel fıkra2.'),
      const FavouriteModal(
          categoryId: 1, jokeId: 3, jokeHeader: 'Papağanın İtirazı', jokeText: 'Ne kadar da komik bir genel fıkra3.'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new FavouritesList(_buildFavouritesList()));
  }
}