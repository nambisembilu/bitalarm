import 'package:bitalarm/pages/home.dart';
import 'package:bitalarm/scopes/alarm_action_scope.dart';
import 'package:bitalarm/utils/common_function.dart';
import 'package:bitalarm/utils/ui_helper.dart';
import 'package:bitalarm/widgets/loading_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';

class AlarmDetailPage extends StatefulWidget {
  final int alarmId;

  const AlarmDetailPage({
    Key key,
    @required this.alarmId,
  }) : super(key: key);

  @override
  _AlarmDetailPageState createState() => _AlarmDetailPageState();
}

class _AlarmDetailPageState extends State<AlarmDetailPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _uiHelper = UiHelper();
  final _alarmActionModel = AlarmActionScope();
  bool _isSaving = false;
  bool _isLoading = false;

  BarTouchData _barTouchData;
  FlTitlesData _titlesData;
  FlBorderData _borderData = FlBorderData(
    show: false,
  );
  List<BarChartGroupData> _barGroups = [];

  @override
  void initState() {
    super.initState();
    devPrint("*** Opening Home Page");
    initFunction();
  }

  void initFunction() async {
    _isLoading = true;
    setState(() {});
    await _alarmActionModel.fetchLocalDataById(widget.alarmId).then((_) {
      _initBarData();
    });
    _isLoading = false;
    setState(() {});
  }

  _initBarData() {
    _barTouchData = BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: const EdgeInsets.all(0),
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.y.round().toString(),
            TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
    _titlesData = FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (double) => TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (double value) {
          return 'A-' + (value + 1).toInt().toString();
        },
      ),
      leftTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );
    for (int i = 0; i < _alarmActionModel.allDatas.length; i++) {
      _barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: double.parse(_alarmActionModel.allDatas[i].actionTime.toString()),
              colors: [Colors.lightBlueAccent, Colors.greenAccent],
              width: 30,
              borderRadius: BorderRadius.circular(10),
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
  }

  _backPage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRightWithFade,
        child: HomePage(),
      ),
    );
  }

  Widget _buildBarChart(BuildContext context) {
    if (_alarmActionModel.allDatas.length > 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
        decoration: _uiHelper.roundBoxBorder(bgColor: Colors.white),
        child: BarChart(
          BarChartData(
            barTouchData: _barTouchData,
            titlesData: _titlesData,
            borderData: _borderData,
            barGroups: _barGroups,
            alignment: BarChartAlignment.spaceAround,
            maxY: double.parse((_alarmActionModel.maxValue + 5).toString()),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: _uiHelper.itemListEmpty(
          context,
          2,
          message: "",
          withImage: true,
        ),
      );
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _uiHelper.heading("Action time (in second)", 10, 0, Colors.black38),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Divider(
              height: 10,
              thickness: 3,
              color: Colors.grey[300],
            ),
          ),
          ScopedModel<AlarmActionScope>(
            model: _alarmActionModel,
            child: ScopedModelDescendant<AlarmActionScope>(
              builder: (context, child, model) {
                if (_isLoading) {
                  return LoadingList(1);
                } else if (model.isError) {
                  return _uiHelper.haveError(context, withImage: true, title: "Opps, something wrong ");
                } else {
                  return _buildBarChart(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _uiHelper.willScopeScaffold(
      onWillPop: () {
        _backPage(context);
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: _uiHelper.bgColor,
        appBar: AppBar(
          titleSpacing: 0,
          leading: GestureDetector(
            onTap: () {
              _backPage(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: _uiHelper.iconBig,
              color: Colors.black87,
            ),
          ),
          backgroundColor: _uiHelper.bgColor,
          title: _uiHelper.appBarHeading(
            "Alarm Detail",
            textColor: Colors.black87,
          ),
          automaticallyImplyLeading: true,
        ),
        body: _buildBodyContent(context),
      ),
    );
  }
}
