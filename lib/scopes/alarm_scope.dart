import 'dart:async';
import 'dart:core';

import 'package:bitalarm/models/alarm_model.dart';
import 'package:bitalarm/services/local_notification.dart';
import 'package:bitalarm/tables/alarm_action_table.dart';
import 'package:bitalarm/tables/alarm_table.dart';
import 'package:bitalarm/utils/common_function.dart';
import 'package:bitalarm/utils/database_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class AlarmInfoScope extends Model {
  final _modelName = 'AlarmInfos';
  final _databaseHelper = DatabaseHelper.instance;
  final _localNotificationService = LocalNotificationService();
  bool isLoading = false;
  bool isFiltered = false;
  bool isLoadingPage = false;
  bool isError = false;
  bool _hasError = false;
  int _perPage = 15;
  int _maxLocalData = 0;

  String errorMessage = '';
  String _selectedId;
  String _message = '';
  String _datasJson;
  List<AlarmInfo> _datas = [];
  List<AlarmInfo> _filteredDatas = [];

  List<AlarmInfo> get allDatas {
    return List.from(_datas);
  }

  List<AlarmInfo> get allFilteredDatas {
    return List.from(_filteredDatas);
  }

  int get perPage {
    return _perPage;
  }

  int get maxLocalData {
    return _maxLocalData;
  }

  String get selectedId {
    return _selectedId;
  }

  String get message {
    return _message;
  }

  bool get hasError {
    return _hasError;
  }

  AlarmInfo get selectedData {
    if (selectedId == null) {
      return null;
    }
    return _datas.firstWhere((AlarmInfo data) {
      return data.alarmId == BigInt.from(int.parse(_selectedId));
    });
  }

  // LOCAL DATABASE

  Future<Null> setMaxLocalDatas() async {
    _maxLocalData = await _databaseHelper.queryRowCount(AlarmInfoTable.name);
  }

  Future<Null> fetchLocalData() async {
    devPrint("[Call function fetch $_modelName]");
    isLoading = true;
    notifyListeners();
    _localNotificationService.initialize();
    await setMaxLocalDatas();
    List<Map<String, dynamic>> trs = await _databaseHelper.queryFilterRows(AlarmInfoTable.name, " ORDER BY " + AlarmInfoTable.columnHour + " DESC LIMIT 0,$_perPage");
    devPrint(trs.toString());
    _datas = alarmInfoFromDatabase(trs);
    for (int i = 0; i < _datas.length; i++) {
      await _localNotificationService.schedulingAlarm(_datas[i]);
    }
    devPrint(_datas.toString());
    isLoading = false;
    notifyListeners();
    return;
  }

  Future<Map<String, dynamic>> insert(var formData) async {
    devPrint("[Call function insert $_modelName]");
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> row = {
      AlarmInfoTable.columnName: formData['name'],
      AlarmInfoTable.columnHour: formData['hour'],
      AlarmInfoTable.columnMinute: formData['minute'],
      AlarmInfoTable.columnRepeat: formData['repeat'] == true ? 1 : 0,
      AlarmInfoTable.columnIsActive: 1,
    };
    _databaseHelper.insert(row, AlarmInfoTable.name);
    _hasError = false;
    errorMessage = 'Data berhasil disimpan';
    isLoading = false;
    notifyListeners();
    return {'status': !_hasError, 'message': errorMessage};
  }

  Future<Map<String, dynamic>> delete(int id) async {
    devPrint("[Call function insert local item]");
    isLoading = true;
    notifyListeners();
    _databaseHelper.delete(id, AlarmInfoTable.name);
    _hasError = false;
    errorMessage = 'Deleted';
    isLoading = false;
    notifyListeners();
    return {'status': !_hasError, 'message': errorMessage};
  }

}
