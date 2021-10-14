import 'package:bitalarm/pages/home.dart';
import 'package:bitalarm/utils/common_function.dart';
import 'package:bitalarm/utils/database_helper.dart';
import 'package:bitalarm/utils/ui_helper.dart';
import 'package:bitalarm/vars/global.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _uiHelper = UiHelper();
  bool _isLoadingData = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    devPrint("*** Opening Splash Screen Page");
    _initFunction();
  }

  _initFunction() async {
    DatabaseHelper.instance.database;
    _isLoadingData = true;
    setState(() {});
    Future.delayed(
      Duration(seconds: 2),
    ).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
    _isLoadingData = false;
    setState(() {});
  }

  Widget _buildBodyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 150,
                  child: Image.asset("assets/logo/bitalarm.png"),
                ),
                Text(
                  "For testing purpose only",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: _uiHelper.fontTitleContent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(
                  global.appVersion,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _uiHelper.fontContent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: _buildBodyContent(),
    );
  }
}
