library hr_mobile.globals;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String deviceUniqueId;
/* CONFIG VARIABLE */
String tokenLogin = '';
String tokenApp = '';
String tokenFcm = '';
String appVersion = '';
String appCompanyName = 'Bibit';
String appClientName = 'BitAlarm';
String appLogoPath = '';
ImageProvider appLogoImage;
bool useTask = true;
// String env = 'local';
// String env = 'beta';
// String env = 'demo';
// String env = 'sandbox';
String env = 'production';
/* APP VARIABLE */
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();