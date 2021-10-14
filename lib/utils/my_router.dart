import 'package:bitalarm/pages/home.dart';
import 'package:bitalarm/pages/splash.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Map<String, Widget Function(BuildContext)> routes =  {
    '/': (BuildContext context) => SplashPage(),
    '/home': (BuildContext context) => HomePage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("on generate Route");
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }
}
