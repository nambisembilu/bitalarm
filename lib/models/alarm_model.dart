import 'dart:convert';

import 'package:intl/intl.dart';

class AlarmInfo {
  final int alarmId;
  String name;
  String hour;
  String minute;
  int repeat;
  int isActive;

  AlarmInfo({
    this.alarmId,
    this.name,
    this.hour,
    this.minute,
    this.repeat,
    this.isActive,
  });

  factory AlarmInfo.fromJson(Map<String, dynamic> map) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return AlarmInfo(
      name: map["name"],
      hour: map['hour'],
      minute: map['minute'],
      repeat: map["repeat"],
      isActive: map["is_active"],
    );
  }

  factory AlarmInfo.fromDatabase(Map<String, dynamic> map) {
    return AlarmInfo(
      alarmId: map['_id'],
      name: map["name"],
      hour: map["hour"],
      minute: map["minute"],
      repeat: map["repeat"],
      isActive: map["is_active"],
    );
  }

  Map<String, dynamic> toJson() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return {
      "name": name,
      "hour": hour,
      "minute": minute,
      "repeat": repeat,
      "is_active": isActive,
    };
  }
}

List<AlarmInfo> alarmInfoFromDatabase(List<Map<String, dynamic>> data) {
  return List<AlarmInfo>.from(data.map((item) => AlarmInfo.fromDatabase(item)));
}

List<AlarmInfo> alarmInfoFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<AlarmInfo>.from(data.map((item) => AlarmInfo.fromJson(item)));
}

String alarmInfoToJson(AlarmInfo data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

List<Map<String, dynamic>> listAlarmInfoDynamicFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Map<String, dynamic>>.from(
    data.map(
      (item) => AlarmInfo.fromJson(item).toJson(),
    ),
  );
}

List<Map<String, dynamic>> listAlarmInfoDynamicFromJsonDecode(var data) {
  return List<Map<String, dynamic>>.from(
    data.map(
      (item) => AlarmInfo.fromJson(item).toJson(),
    ),
  );
}

List<Map<String, dynamic>> listAlarmInfoDynamicFromDatas(List<AlarmInfo> datas) {
  return List<Map<String, dynamic>>.from(
    datas.map(
      (item) => item.toJson(),
    ),
  );
}
