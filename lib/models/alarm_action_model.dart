import 'dart:convert';
import 'package:intl/intl.dart';

class AlarmAction {
  final int alarmId;
  int actionTime;

  AlarmAction({
    this.alarmId,
    this.actionTime,
  });

  factory AlarmAction.fromJson(Map<String, dynamic> map) {
    return AlarmAction(
      alarmId: map["alarm_id"],
      actionTime: map['action_time'],
    );
  }

  factory AlarmAction.fromDatabase(Map<String, dynamic> map) {
    return AlarmAction(
      alarmId: map['alarm_id'],
      actionTime: map["action_time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarm_id": alarmId,
      "action_time": actionTime,
    };
  }
}

List<AlarmAction> alarmActionFromDatabase(List<Map<String, dynamic>> data) {
  return List<AlarmAction>.from(data.map((item) => AlarmAction.fromDatabase(item)));
}

List<AlarmAction> alarmActionFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<AlarmAction>.from(data.map((item) => AlarmAction.fromJson(item)));
}

String alarmActionToJson(AlarmAction data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

List<Map<String, dynamic>> listAlarmActionDynamicFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Map<String, dynamic>>.from(
    data.map(
          (item) => AlarmAction.fromJson(item).toJson(),
    ),
  );
}

List<Map<String, dynamic>> listAlarmActionDynamicFromJsonDecode(var data) {
  return List<Map<String, dynamic>>.from(
    data.map(
          (item) => AlarmAction.fromJson(item).toJson(),
    ),
  );
}

List<Map<String, dynamic>> listAlarmActionDynamicFromDatas(List<AlarmAction> datas) {
  return List<Map<String, dynamic>>.from(
    datas.map(
          (item) => item.toJson(),
    ),
  );
}
