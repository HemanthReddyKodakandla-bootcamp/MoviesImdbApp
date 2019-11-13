class Movies {
  String imdbID;
  String title;
  String director;
  String writer;
  String released;
  String rated;
  String imdbRating;
  String poster;
  String awards;
  String genres;
  String languages;
  String country;
  String cast;
  String runtime;
  String images;
  String plot;

  Movies(
      {this.imdbID,
        this.title,
        this.director,
        this.writer,
        this.released,
        this.rated,
        this.imdbRating,
        this.country,
        this.images,
        this.awards,
        this.cast,
        this.genres,
        this.languages,
        this.poster,
        this.runtime,
        this.plot
      }
        );

  Movies.map(dynamic obj) {
    this.title = obj["Title"];
    this.director = obj["Director"];
    this.writer = obj["Writer"];
    this.released = obj["Released"];
    this.rated = obj["Rated"];
    this.imdbRating = obj["imdbRating"];
    this.poster = obj["Poster"];
    this.languages = obj["Language"];
    this.genres = obj["Genre"];
    this.cast = obj["Actors"];
    this.country = obj["Country"];
    this.awards = obj["Awards"];
    this.images = obj["Images"];
    this.imdbID = obj["imdbID"];
    this.runtime = obj["Runtime"];
    this.plot = obj["Plot"];

  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["imdbID"] = imdbID ?? "";
    map["Title"] = title ?? "";
    map["Director"] = director ?? "";
    map["Writer"] = writer ?? "";
    map["Released"] = released ?? "";
    map["Rated"] = rated ?? "";
    map["imdbRating"] = imdbRating ?? "";
    map["Poster"]= poster ?? "";
    map["Languages"]= languages ?? "";
    map["Cast"]= cast ?? "";
    map["Country"]= country ?? "";
    map["Awards"]= awards ?? "";
    map["Runtime"]= runtime ?? "";
    map["Genres"] = genres ?? "";
    map["Images"] = images ?? "";
    map["Plot"] = plot ?? "";
    return map;
  }

  @override
  String toString() {
    return 'Movies{'
        'ImdbID:$imdbID,'
        'Title:$title,'
        'Director:$director,'
        'Writer:$writer,'
        'Released:$released,'
        'Rated:$rated,'
        'imdbRating:$imdbRating,'
        'Poster:$poster,'
        'Languages:$languages,'
        'Genres:$genres,'
        'Cast:$cast,'
        'Country:$country,'
        'Awards:$awards,'
        'Images:$images,'
        'Runtime:$runtime,'
        'Ploy:$plot,'
        '}';
  }
}
