import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'movie_modal.dart';

class MoviesDataBaseHelper {
  /// Here we create the instance of the class at the time of declaring the static data member,
  /// so instance of the class is created at the time of classloading.
  /// It represents Singleton Design pattern of Early instantiation
  static final MoviesDataBaseHelper _dataBaseHelperInstance =
      new MoviesDataBaseHelper.internal();

  ///Private constructor, it will prevent to instantiate the Singleton class from outside the class.

  /// Using private constructor we can ensure that no more than one object can be created at a time.
  /// By providing a private constructor you prevent class instances from being created in any place other than this very class.
  MoviesDataBaseHelper.internal();

  /// Use the factory keyword when implementing a constructor that doesn't always create a new instance of its class.
  /// For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype.
  factory MoviesDataBaseHelper() => _dataBaseHelperInstance;

  /// Database table name and it should be final and it should not be changed. That's why we declared as final
  final String attendeesTable = 'Movies';

  /// Base class of Database from Sqflite plugin. It's an abstract class to send SQL commands for CRUD Operations
  static Database _attendeesDatabase;

  /// To perform asynchronous operations in Dart, you can use the Future class and the async and await keywords.
  ///
  /// refer to this link for better understanding of the Future, async and await keywords
  /// https://dart.dev/codelabs/async-await
  ///
  /// A future (lower case “f”) is an instance of the Future (capitalized “F”) class.
  /// A future represents the result of an asynchronous operation, and can have two states: uncompleted or completed.
  Future<Database> get db async {
    if (_attendeesDatabase != null) {
      return _attendeesDatabase;
    }
    _attendeesDatabase = await initDb();

    return _attendeesDatabase;
  }

  /// For async keyword, please refer to the below link
  /// https://dart.dev/guides/language/language-tour#asynchrony-support
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  /// Method to create the DB with Database variable and Dbversion
  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $attendeesTable(imdbID TEXT PRIMARY KEY, Title TEXT,Director TEXT, Writer TEXT, Released TEXT, Rated TEXT, imdbRating TEXT, Poster TEXT, Languages TEXT, Cast TEXT,Country TEXT,Awards TEXT,Runtime TEXT, Genres TEXT,Images TEXT,Plot TEXT)");
  }

  /// Method to insert the data into DB with insert query by passing table name and model data
  Future<int> saveAttendeesDetails(Movies movie) async {
    var dbClient = await db;
    int result = await dbClient.insert(attendeesTable, movie.toMap());
    return result;
  }

  /// Method to fetch all the user information from the Database using rawQuery
  Future<List<Movies>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Movies');
    List<Movies> moviesList = new List();
    for (int i = 0; i < list.length; i++) {
      var eachMovie = new Movies(
        imdbID: list[i]["imdbID"],
        title: list[i]["Title"],
        director: list[i]["Director"],
        rated: list[i]["Rated"],
        released: list[i]["Released"],
        imdbRating: list[i]["imdbRating"],
        writer: list[i]["Writer"],
        country: list[i]["Country"],
        awards: list[i]["Awards"],
        cast: list[i]["Cast"],
        genres: list[i]["Genres"],
        languages: list[i]["Languages"],
        poster: list[i]["Poster"],
        images: list[i]["Images"],
        plot: list[i]["Plot"],
      );
      moviesList.add(eachMovie);
    }
    print("DB data.... " + moviesList.toString());
    return moviesList;
  }

  /// Method to fetch all the user information from the Database using rawQuery
  Future<int> deleteUsers(Movies movies) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Movies WHERE imdbID = ?', [movies.imdbID]);
    return res;
  }

  /// Method to delete all the user information from the Database using rawDelete
  Future<int> deleteAllUsers() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete('DELETE FROM Movies');
    return res;
  }

  /// Method to update the attendees information using update query.
  Future<bool> update(Movies movies) async {
    print(movies.toMap());
    var dbClient = await db;
    int res = await dbClient.update("Movies", movies.toMap(),
        where: "imdbID = ?", whereArgs: <String>[movies.imdbID]);
    print(res);
    return res > 0 ? true : false;
  }
}
