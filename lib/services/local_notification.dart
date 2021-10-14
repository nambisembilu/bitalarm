import 'dart:io';

import 'package:bitalarm/models/alarm_model.dart';
import 'package:bitalarm/scopes/alarm_action_scope.dart';
import 'package:bitalarm/scopes/alarm_scope.dart';
import 'package:bitalarm/utils/common_function.dart';
import 'package:bitalarm/vars/global.dart' as global;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class LocalNotificationService {
  final _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  final _alarmActionModel = new AlarmActionScope();
  AndroidInitializationSettings _initializationSettingsAndroid;
  IOSInitializationSettings _initializationSettingsIOS;
  MacOSInitializationSettings _initializationSettingsMacOS;
  InitializationSettings _initializationSettings;

  void initialize() async {
    _initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    _initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    _initializationSettingsMacOS = MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    _initializationSettings = InitializationSettings(
      android: _initializationSettingsAndroid,
      iOS: _initializationSettingsIOS,
      macOS: _initializationSettingsMacOS,
    );
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings, onSelectNotification: (String payload) async {
      if (payload != null) {
        devPrint(payload.toString());
        List<String> splitPayload = payload.split('&');
        devPrint(splitPayload);
        int alarmId = int.parse(splitPayload[0]);
        String alarmPayloadStr = splitPayload[1].toString();
        String alarmType = splitPayload[2].toString();
        devPrint(alarmId);
        devPrint(alarmPayloadStr);
        devPrint(alarmType);
        if (alarmType == 'single') {
          DateTime alarmTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(alarmPayloadStr);
          DateTime alarmClicked = DateTime.now();
          Duration diffTime = alarmClicked.difference(alarmTime);
          devPrint(alarmId);
          devPrint(alarmTime);
          devPrint(alarmClicked);
          devPrint(diffTime.inSeconds);
          await _alarmActionModel.insert(alarmId, diffTime.inSeconds);
        } else {
          DateTime alarmTimePayload = DateFormat("yyyy-MM-dd HH:mm:ss").parse(alarmPayloadStr);
          String alarmDateNow = DateFormat("yyyy-MM-dd").format(DateTime.now());
          DateTime alarmTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(alarmDateNow + ' ' + alarmTimePayload.hour.toString() + ':' + alarmTimePayload.minute.toString() + ':00');
          DateTime alarmClicked = DateTime.now();
          Duration diffTime = alarmClicked.difference(alarmTime);
          devPrint(alarmId);
          devPrint(alarmTime);
          devPrint(alarmClicked);
          devPrint(diffTime.inSeconds);
          await _alarmActionModel.insert(alarmId, diffTime.inSeconds);
        }
      }
    });
    // ios requestPermissions method with desired permissions
    if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  Future<Null> schedulingAlarm(AlarmInfo alarm) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'bitalarm-notification',
      'BitAlarm Notification',
      'alarm notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('notification_check'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_check.caf',
      badgeNumber: 1,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    String singleAlarmStrTime = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString() + ' ' + alarm.hour + ':' + alarm.minute + ':00';

    if (alarm.repeat == 1) {
      await _flutterLocalNotificationsPlugin.showDailyAtTime(
        alarm.alarmId,
        global.appClientName,
        alarm.name,
        Time(
          int.parse(alarm.hour),
          int.parse(alarm.minute),
          0,
        ),
        platformChannelSpecifics,
        payload: alarm.alarmId.toString() + '&' + singleAlarmStrTime + '&repeat',
      );
    } else {
      DateTime singleAlarmTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(singleAlarmStrTime);
      devPrint("Str time : " + singleAlarmStrTime);
      devPrint(" time : " + singleAlarmTime.toString());
      if (DateTime.now().isBefore(singleAlarmTime)) {
        await _flutterLocalNotificationsPlugin.schedule(
          alarm.alarmId,
          global.appClientName,
          alarm.name,
          singleAlarmTime,
          platformChannelSpecifics,
          payload: alarm.alarmId.toString() + '&' + singleAlarmTime.toString() + '&single',
        );
      }
    }
  }
}
