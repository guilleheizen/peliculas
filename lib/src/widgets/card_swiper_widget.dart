import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

  const CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top:30.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return 
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              "https://www.megaeletronicos.com/assets/img/banners/bn3.jpg",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: 400.0,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}