import 'package:infineon_floodmonitoring/pages/about/about.dart';
import 'package:infineon_floodmonitoring/pages/homepage/homepage.dart';
import 'package:infineon_floodmonitoring/pages/homepage/intro_page.dart';
import 'package:infineon_floodmonitoring/pages/searchSensor/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infineon_floodmonitoring/pages/settings/settings.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  //final arguments = settings.arguments;
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(
          builder: (BuildContext context) => IntroPageView());
      break;
    case "/detailPage":
      return MaterialPageRoute(builder: (BuildContext context) => MyHomePage());
      break;
    case "/search":
      return MaterialPageRoute(
          builder: (BuildContext context) => SearchBarPage());
      break;
    case "/about":
      return MaterialPageRoute(
          builder: (BuildContext context) => AboutDetails());
      break;
    case "/settings":
      return MaterialPageRoute(
          builder: (BuildContext context) => SettingsPage());
      break;
    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => IntroPageView());
  }
}

//generates and push a route with no animation for stacking multiple pages
class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

Future<T> pushWithoutAnimation<T extends Object>(Widget page, context) {
  Route route = NoAnimationPageRoute(builder: (BuildContext context) => page);
  return Navigator.push(context, route);
}
