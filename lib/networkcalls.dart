import 'dart:convert';

import 'package:flutter_movie_description_app/db/db_helper.dart';
import 'package:flutter_movie_description_app/db/movie_modal.dart';
import 'package:flutter_movie_description_app/movie_bloc.dart';
import 'package:http/http.dart' as http;
class NetworkCall{
  String url = "https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/523c324c7fcc36efab8224f9ebb7556c09b69a14/Film.JSON";
  List movieData;
  Future<List> getMovieDetails() async{

    var response = await http.get(Uri.encodeFull(url),
        headers: {'Accept':'application/json'}
    );

    var responseData = jsonDecode(response.body);

    movieData= responseData;

    MoviesDataBaseHelper().getUser().then((data){

      if(data.length == 0){
        for(var movie in movieData){
          Movies each_movie = Movies(
              imdbID: movie['imdbID'],
              title: movie['Title'],
              director: movie['Director'],
              rated: movie['Rated'],
              released: movie['Released'],
              writer: movie['Writer'],
              imdbRating: movie['imdbRating'],
              poster: movie['Poster'],
              awards: movie['Awards'],
              cast: movie['Actors'],
              country: movie['Country'],
              genres: movie['Genre'],
              languages: movie['Language'],
              images: jsonEncode(movie['Images']).toString(),
              runtime: movie['Runtime']
          );
          MoviesDataBaseHelper().saveAttendeesDetails(each_movie);
        }
      }
      else{
        MoviesDataBaseHelper().deleteAllUsers();
        for(var movie in movieData){
          Movies each_movie = Movies(
              imdbID: movie['imdbID'],
              title: movie['Title'],
              director: movie['Director'],
              rated: movie['Rated'],
              released: movie['Released'],
              writer: movie['Writer'],
              imdbRating: movie['imdbRating'],
              poster: movie['Poster'],
              awards: movie['Awards'],
              cast: movie['Actors'],
              country: movie['Country'],
              genres: movie['Genre'],
              languages: movie['Language'],
              images: jsonEncode(movie['Images']).toString(),
              runtime: movie['Runtime']
          );
          MoviesDataBaseHelper().saveAttendeesDetails(each_movie);
        }
      }
    });

    print(MoviesDataBaseHelper().getUser());

//    bloc.addMovies.add((MoviesDataBaseHelper().getUser() as List)[0]);

    return MoviesDataBaseHelper().getUser();

  }
}