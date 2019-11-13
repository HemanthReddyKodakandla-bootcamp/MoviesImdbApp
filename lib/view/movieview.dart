import 'package:flutter/material.dart';
import 'package:flutter_movie_description_app/db/db_helper.dart';
import 'package:flutter_movie_description_app/movie_bloc.dart';
import 'package:flutter_movie_description_app/networkcalls.dart';
import 'package:flutter_movie_description_app/view/fulldescription.dart';
import 'package:flutter_movie_description_app/routes.dart';

class MovieThumbnailWidget extends StatefulWidget {
  @override
  _MovieThumbnailWidgetState createState() => _MovieThumbnailWidgetState();
}

class _MovieThumbnailWidgetState extends State<MovieThumbnailWidget> {
  List data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkCall().getMovieDetails().then((ondata) {
      setState(() {
        data = ondata;
      });
        bloc.addMovies.add(data);
      debugPrint('response $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Movie Ratings',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              onPressed: (){
                NetworkCall().getMovieDetails().then((ondata) {
                  setState(() {
                    data = ondata;
                  });
                  debugPrint('response $data');
                });              }
          , child: Text('Get ALL Movies',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: Container(
                      child: Hero(
                          tag: data[index].title,
                          child: Image.network(
                            data[index].poster.toString().replaceAll(
                                  'http://',
                                  'https://',
                                ),
                            height: 100.0,
                          ))),
                  title: _textWidget(
                      context, index, "Movie : ", data[index].title),
                  subtitle: Wrap(
                    children: <Widget>[
                      _textWidget(context, index, "Director : ",
                          data[index].director),
                    ],
                  ),
                  trailing: Container(
                    alignment: Alignment.centerRight,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.pink,
                            ),
                            Text(data[index].imdbRating),
                          ],
                        ),
                        IconButton(icon: Icon(Icons.delete), onPressed: () {
                          MoviesDataBaseHelper().deleteUsers(data[index]);
                          MoviesDataBaseHelper().getUser().then((onvalue){
                            setState(() {
                              data = onvalue;
                            });
                          });
                        }),
                      ],
                    ),
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        SlidePageRoute(
                            page: FullDescriptionWidget(
                          movieFullData: data[index],
                        )));
                  },
                ),
              );
            }),
      ),
    );
  }

  _textWidget(BuildContext context, int index, String name, String details) {
    return RichText(
      text: TextSpan(
        text: name,
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: details, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
