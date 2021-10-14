import 'package:bitalarm/pages/splash.dart';
import 'package:bitalarm/utils/my_router.dart';
import 'package:bitalarm/vars/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load global Variable for splash
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  global.appVersion = packageInfo.version;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: data.textScaleFactor * 1),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      title: global.appClientName,
      initialRoute: '/',
      routes: MyRouter.routes,
      onGenerateRoute: MyRouter.generateRoute,
      onUnknownRoute: (RouteSettings settings) {
        print('on unknown route');
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => SplashPage(),
        );
      },
      navigatorKey: global.navigatorKey,
    );
  }
}
