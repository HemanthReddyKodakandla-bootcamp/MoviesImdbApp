import 'package:flutter/material.dart';
//class Routes extends StatelessWidget {
//  String initialRoute = '/';
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      routes: routes(context),
//      initialRoute: '/',
//    );
//  }
//
//  static routes(BuildContext context){
//    return <String, WidgetBuilder>{
//      '/' : (context) => MovieThumbnailWidget(),
////      '/fulldesc': (context) => FullDescriptionWidget(movieFullData: moviedata,),
//    };
//  }
//}
class SlidePageRoute extends PageRouteBuilder
{
  final Widget page;
  SlidePageRoute({this.page}):super (
      pageBuilder : (
          BuildContext context,
          Animation < double > animation,
          Animation < double > secondaryAnimation,
          )=> page,
      transitionsBuilder : (
          BuildContext context,
          Animation < double > animation,
          Animation < double > secondaryAnimation,
          Widget child,
          ) => SlideTransition(
        position: Tween<Offset>(
          begin : const Offset(-1,-1),
          end: Offset.zero,
        ).animate(animation),
        child : child,
      )
  );
}