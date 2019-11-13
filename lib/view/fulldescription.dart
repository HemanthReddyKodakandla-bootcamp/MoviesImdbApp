import 'dart:convert';

import 'package:flutter/material.dart';

class FullDescriptionWidget extends StatefulWidget {
  var movieFullData;
  FullDescriptionWidget(
      {Key key,
        @required this.movieFullData,
        })
      : super(key: key);
  @override
  _FullDescriptionWidgetState createState() => _FullDescriptionWidgetState();
}

class _FullDescriptionWidgetState extends State<FullDescriptionWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageWidget(jsonDecode(widget.movieFullData.images));
    chip(widget.movieFullData.genres);
    language(widget.movieFullData.languages);
    country(widget.movieFullData.country);

  }

  List<Widget> image = new List();
  List<Widget> chipdata = new List();
  List<Widget> languageChipData = new List();
  List<Widget> countryChipData = new List();

  chip(var data){
    var chipsData = data.split(",");
    for(var chip in chipsData){
      chipdata.add(
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Chip(
              label: Text(chip),
            ),
          ));
    }
  }
  language(var data){
    var chipsData = data.split(",");
    for(var chip in chipsData){
      languageChipData.add(
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Chip(
              label: Text(chip),
            ),
          ));
    }
  }

  country(var data){
    var countryData = data.split(",");
    for(var chip in countryData){
      countryChipData.add(
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Chip(
              label: Text(chip),
            ),
          ));
    }
  }

  imageWidget(var data){
    for(var url in data){
        image.add(
            Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.only(left: 10.0),
          child: Image.network(url,),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
          title: Text(widget.movieFullData.title,style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15.0),
                alignment: Alignment.center,
                  child: Hero(
                    tag: widget.movieFullData.title,
                    child: Image.network(widget.movieFullData.poster.toString().replaceAll('http://', 'https://',),
                      height: MediaQuery.of(context).size.height*0.33,
                    ),
                  ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 15.0,bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _text(context,'Ratings : ', widget.movieFullData.imdbRating),
                          Icon(Icons.star,color: Color(0xFFFFD700),)
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 8.0),
                        child:_text(context,'Rated : ',widget.movieFullData.rated),
                      )
                    ],
                  )
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(widget.movieFullData.plot,style: TextStyle(color: Colors.black87,fontSize: 15.0,fontWeight: FontWeight.w500),),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _text(context,'Released : ', widget.movieFullData.released)  ,
                    _text(context,'Runtime : ',widget.movieFullData.runtime),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: _text(context, "Director : ", widget.movieFullData.director)),
              Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: _text(context, "Writers : ", widget.movieFullData.writer)),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: _text(context, "Cast : ", widget.movieFullData.cast)),
             showText('Genres'),
              Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: chips(),
              ),
               showText('Languages'),
              Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: languageChips(),
              ),
              showText('Released Countries'),
              Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: countryChips(),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child:
                _text(context, "Awards : ", widget.movieFullData.awards)
              ),
              Container(
                child: images(),
              )

            ],
          ),
        ),
      ),
    );
  }

  _text(BuildContext context,String name,String details) {
    return RichText(
      text: TextSpan(
        text: name,
        style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(text: details, style: TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF44464D))),
        ],
      ),
    );
  }
  
  chips(){
    return Container(
      child: Row(
        children: chipdata
    ),
    ) ;
  }
  languageChips(){
    return Container(
      child: Row(
          children: languageChipData
      ),
    ) ;
  }

  countryChips(){
      return Container(
        child: Row(
            children: countryChipData
        ),
      ) ;

  }
  images(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: image
      ),
    );
  }

  showText(String text){
    return Container(
      child: Text(text,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontSize: 20.0),),
    );
  }
}

