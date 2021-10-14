import 'package:bitalarm/models/alarm_model.dart';
import 'package:bitalarm/pages/alarm/alarm_detail.dart';
import 'package:bitalarm/scopes/alarm_scope.dart';
import 'package:bitalarm/utils/common_function.dart';
import 'package:bitalarm/utils/ui_helper.dart';
import 'package:bitalarm/widgets/loading_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _uiHelper = UiHelper();
  final _alarmModel = AlarmInfoScope();
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSaving = false;
  bool _isLoading = false;
  int _wantToExit = 0;
  Map<String, dynamic> _formData = {
    "name": "",
    "hour": DateTime.now().hour.toString(),
    "minute": DateTime.now().minute.toString(),
    "repeat": true,
    "is_active": "",
  };

  @override
  void initState() {
    super.initState();
    devPrint("*** Opening Home Page");
    initFunction();
  }

  void initFunction() async {
    _isLoading = true;
    setState(() {});
    await _alarmModel.fetchLocalData();
    _isLoading = false;
    setState(() {});
  }

  Future<bool> onBackExit() {
    _wantToExit++;
    if (_wantToExit % 2 == 0) {
      _wantToExit = 0;
      MoveToBackground.moveTaskToBack();
    } else if (_wantToExit % 1 == 0) {
      Toast.show(
        "Press one more time to quit.",
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
      );
    }
  }

  Widget _buildAlarmContainer(BuildContext context, AlarmInfo alarm, int index) {
    var gradientColor = UiHelper.gradientTemplate[index % 6];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmDetailPage(
              alarmId: alarm.alarmId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColor.last.withOpacity(0.4),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(2, 0),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.label,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      alarm.name,
                      style: TextStyle(
                        fontSize: _uiHelper.fontBig,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                Switch(
                  onChanged: (bool value) {
                    alarm.isActive = value ? 1 : 0;
                    setState(() {});
                  },
                  value: alarm.isActive == 1 ? true : false,
                  activeColor: Colors.white,
                ),
              ],
            ),
            alarm.repeat == 1
                ? Text(
                    'Repeated',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      alarm.hour.padLeft(2, '0'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _uiHelper.fontSuperBig,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      ":",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _uiHelper.fontSuperBig,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      alarm.minute.padLeft(2, '0'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _uiHelper.fontSuperBig,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () async {
                    Map<String, dynamic> response = await _alarmModel.delete(alarm.alarmId);
                    if (response['status']) {
                      Toast.show(
                        "Deleted",
                        context,
                        backgroundColor: _uiHelper.dangerColor,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM,
                      );
                    }
                    await _alarmModel.fetchLocalData();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return _uiHelper.formFieldWrapper(
      childField: FormBuilderTextField(
        attribute: "name",
        maxLines: 1,
        textCapitalization: TextCapitalization.words,
        validators: [FormBuilderValidators.required()],
        onChanged: (value) {
          _formData['name'] = value;
        },
      ),
    );
  }

  Widget _buildHourMinutePicker() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: CupertinoDatePicker(
        use24hFormat: true,
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (val) {
          _formData['hour'] = val.hour.toString();
          _formData['minute'] = val.minute.toString();
          devPrint(_formData['time']);
        },
      ),
    );
  }

  Widget _buildFormCheckRepeat(StateSetter setSheetState) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: CupertinoSwitch(
        value: _formData['repeat'],
        onChanged: (bool newValue) {
          setSheetState(() {
            setState(() {
              _formData['repeat'] = !_formData['repeat'] ? true : false;
              devPrint(_formData['repeat']);
            });
          });
        },
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        height: 40,
        child: RaisedButton(
          color: _uiHelper.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_uiHelper.radiusBorderRounded),
          ),
          child: Text(
            "SAVE",
            style: TextStyle(
              fontFamily: _uiHelper.fontFamilyStyled,
              fontSize: _uiHelper.fontTitleContent,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            Map<String, dynamic> response = await _alarmModel.insert(_formData);
            if (response['status']) {
              Toast.show(
                "Data has been saved",
                context,
                backgroundColor: _uiHelper.confirmColor,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
              );
            }
            await _alarmModel.fetchLocalData();
          },
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
        ),
        height: 40,
        child: RaisedButton(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_uiHelper.radiusBorderRounded),
          ),
          child: Text(
            "CANCEL",
            style: TextStyle(
              fontFamily: _uiHelper.fontFamilyStyled,
              fontSize: _uiHelper.fontTitleContent,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildFormNewAlarm(BuildContext context, StateSetter setSheetState) {
    return Container(
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 10),
            _uiHelper.formLabel("Title"),
            _buildNameField(),
            SizedBox(height: 10),
            _uiHelper.formLabel("Time"),
            _buildHourMinutePicker(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _uiHelper.formLabel("Repeat"),
                _buildFormCheckRepeat(setSheetState),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildCancelButton(context),
                Padding(
                  padding: EdgeInsets.all(2),
                ),
                _buildSaveButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildListAlarm(BuildContext context, List<AlarmInfo> alarms) {
    if (alarms.length > 0) {
      return ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          return _buildAlarmContainer(context, alarms[index], index);
        },
      );
    } else {
      return _uiHelper.itemListEmpty(context, 1.5, withImage: true);
    }
  }

  Widget _buildBodyContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 10,
        left: 15,
        right: 15,
      ),
      child: ScopedModel<AlarmInfoScope>(
        model: _alarmModel,
        child: ScopedModelDescendant<AlarmInfoScope>(
          builder: (context, child, model) {
            if (_isLoading) {
              return LoadingList(5);
            } else if (model.isError) {
              return _uiHelper.haveError(context, withImage: true, title: "Opps, something wrong ");
            } else {
              return _buildListAlarm(context, model.allDatas);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _uiHelper.willScopeScaffold(
      onWillPop: onBackExit,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: _uiHelper.bgColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _uiHelper.showCustomModalSheet(
              context: context,
              height: _uiHelper.screenHeightPer(context, 1.2),
              title: "New Alarm",
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setSheetState) {
                  return _buildFormNewAlarm(context, setSheetState);
                },
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.black87,
          ),
          backgroundColor: Colors.white,
        ),
        appBar: AppBar(
          backgroundColor: _uiHelper.bgColor,
          title: _uiHelper.appBarHeading(
            "Alarms",
            textColor: Colors.black87,
          ),
          automaticallyImplyLeading: false,
        ),
        body: _buildBodyContent(context),
      ),
    );
  }
}
