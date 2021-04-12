import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

    String seleccion = '';
    final peliculasProvider = new PeliculasProvider();

    @override
    List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro Appbar
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          }
        ),
      ];
      // throw UnimplementedError();
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del appbar

      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        }
      ); 
      // throw UnimplementedError();
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Builder que crea los resultados que vamos a mostrar
      return Center(
        child: Container(
          height: 400.0,
          width: 400.0,
          color: Colors.redAccent,
          child: Text(seleccion),
        ),
      );
      // throw UnimplementedError();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      // Son las sugerencias que aparecen cuando la persona escribe
      
      if ( query.isEmpty ) {
        return Container();
      } else {
        return FutureBuilder(
          future: peliculasProvider.buscarPelicula(query),
          builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
            if(snapshot.hasData){

              final peliculas = snapshot.data;

              return ListView(
                children: peliculas.map( (pelicula) {
                  return ListTile(
                     leading: ClipRRect(
                       borderRadius: BorderRadius.circular(10.0),
                       child: FadeInImage(
                         image: NetworkImage(pelicula.getPosterImg()),
                         placeholder: AssetImage('assets/img/no-image.jpg'),
                         fit:BoxFit.contain,
                         width: 50.0,
                       ),
                     ),
                     title: Text(pelicula.title),
                     subtitle: Text(pelicula.originalTitle),
                     onTap: (){
                       close(context, null);
                       pelicula.uniqueId = '';
                       Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                     },
                  );
                }).toList()
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      }

      // throw UnimplementedError();
    }
    @override
    String get searchFieldLabel => "Buscar...";

}