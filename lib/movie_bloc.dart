import 'dart:async';

import 'package:flutter_movie_description_app/db/movie_modal.dart';

class MovieBloc{

  StreamController<List<Movies>> streamController = StreamController();

  Sink get addMovies => streamController.sink;

  Stream<List<Movies>> get moviesData => streamController.stream;

  dispose(){
    streamController.close();
  }
}
final bloc = MovieBloc();