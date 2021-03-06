import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  
  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en Cines'),
          backgroundColor: Colors.black,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(children: [
        SizedBox(height: 10.0),
        Text('Populares', style: Theme.of(context).textTheme.subtitle1),
        SizedBox(height: 10.0),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(
                peliculas: snapshot.data,
                siguientePagina: peliculasProvider.getPopulares,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ]),
    );
  }
}
