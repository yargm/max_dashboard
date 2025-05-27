import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/visitor_by_channels_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsController extends MyController {
  String selectActivity = "Year";
  List<VisitorByChannelsModel> visitorByChannel = [];
  final TooltipBehavior columnChartToolTip = TooltipBehavior(enable: true, format: 'point.x : point.y', tooltipPosition: TooltipPosition.pointer);
  final TooltipBehavior audienceOverview = TooltipBehavior(enable: true, format: 'point.x : point.y', tooltipPosition: TooltipPosition.pointer);

  @override
  void onInit() {
    VisitorByChannelsModel.dummyList.then((value) {
      visitorByChannel = value;
      update();
    });
    super.onInit();
  }

  void onSelectedActivity(String time) {
    selectActivity = time;
    update();
  }

  void removeData(index) {
    visitorByChannel.removeAt(index);
    update();
  }

  final List<ChartSampleData> columnChart = <ChartSampleData>[
    ChartSampleData(x: 2010, y: 32, yValue: 50),
    ChartSampleData(x: 2011, y: 44, yValue: 40),
    ChartSampleData(x: 2012, y: 40, yValue: 60),
    ChartSampleData(x: 2013, y: 50, yValue: 38),
    ChartSampleData(x: 2014, y: 10, yValue: 28),
    ChartSampleData(x: 2015, y: 20, yValue: 16),
    ChartSampleData(x: 2016, y: 30, yValue: 50),
  ];

  final List<ChartSampleData> audienceOverviewChart = [
    ChartSampleData(x: 2018, y: 50, yValue: 38),
    ChartSampleData(x: 2019, y: 10, yValue: 28),
    ChartSampleData(x: 2020, y: 32, yValue: 50),
    ChartSampleData(x: 2020, y: 44, yValue: 40),
    ChartSampleData(x: 2020, y: 40, yValue: 60),
    ChartSampleData(x: 2020, y: 50, yValue: 38),
    ChartSampleData(x: 2021, y: 10, yValue: 28),
    ChartSampleData(x: 2022, y: 20, yValue: 16),
    ChartSampleData(x: 2023, y: 30, yValue: 50)
  ];
}
