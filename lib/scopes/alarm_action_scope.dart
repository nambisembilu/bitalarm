import 'dart:async';
import 'dart:core';

import 'package:bitalarm/models/alarm_action_model.dart';
import 'package:bitalarm/models/alarm_model.dart';
import 'package:bitalarm/tables/alarm_action_table.dart';
import 'package:bitalarm/tables/alarm_table.dart';
import 'package:bitalarm/utils/common_function.dart';
import 'package:bitalarm/utils/database_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class AlarmActionScope extends Model {
  final _modelName = 'AlarmActions';
  final _databaseHelper = DatabaseHelper.instance;
  bool isLoading = false;
  bool isFiltered = false;
  bool isLoadingPage = false;
  bool isError = false;
  bool _hasError = false;
  int _perPage = 15;
  int _maxLocalData = 0;
  int _maxValue = 0;

  String errorMessage = '';
  String _selectedId;
  String _message = '';
  String _datasJson;
  List<AlarmAction> _datas = [];
  List<AlarmAction> _filteredDatas = [];

  List<AlarmAction> get allDatas {
    return List.from(_datas);
  }

  List<AlarmAction> get allFilteredDatas {
    return List.from(_filteredDatas);
  }

  int get perPage {
    return _perPage;
  }

  int get maxLocalData {
    return _maxLocalData;
  }

  int get maxValue {
    return _maxValue;
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

  AlarmAction get selectedData {
    if (selectedId == null) {
      return null;
    }
    return _datas.firstWhere((AlarmAction data) {
      return data.alarmId == BigInt.from(int.parse(_selectedId));
    });
  }

  // LOCAL DATABASE

  Future<Null> setMaxLocalDatas() async {
    _maxLocalData = await _databaseHelper.queryRowCount(AlarmActionTable.name);
  }

  Future<Null> fetchLocalDataById(int alarmId) async {
    devPrint("[Call function fetch $_modelName]");
    isLoading = true;
    notifyListeners();
    await setMaxLocalDatas();
    List<Map<String, dynamic>> trs = await _databaseHelper.queryFilterRows(AlarmActionTable.name, " WHERE " + AlarmActionTable.columnAlarmId + "=" + alarmId.toString());
    devPrint(trs.toString());
    _datas = alarmActionFromDatabase(trs);
    for(int i=0;i<_datas.length;i++){
      if(_datas[i].actionTime>_maxValue){
        _maxValue=_datas[i].actionTime;
      }
    }
    devPrint(_datas.toString());
    isLoading = false;
    notifyListeners();
    return;
  }

  Future<Map<String, dynamic>> insert(int alarmId, int actionTime) async {
    devPrint("[Call function insert $_modelName]");
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> row = {
      AlarmActionTable.columnAlarmId: alarmId,
      AlarmActionTable.columnActionTime: actionTime,
    };
    _databaseHelper.insert(row, AlarmActionTable.name);
    _hasError = false;
    errorMessage = 'Data berhasil disimpan';
    isLoading = false;
    notifyListeners();
    return {'status': !_hasError, 'message': errorMessage};
  }
}
