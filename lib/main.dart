import 'package:flutter/material.dart';
import 'package:flutter_movie_description_app/routes.dart';
import 'package:flutter_movie_description_app/view/movieview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieThumbnailWidget(),
    );
  }
}


