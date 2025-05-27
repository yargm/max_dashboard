import 'package:flutter/material.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/product_order_modal.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcommerceController extends MyController {
  List<ChartSampleData>? salesAnalyticsData;
  List<ProductOrderModal> order = [];
  String selectedTimeByLocation = "Year";

  @override
  void onInit() {
    ProductOrderModal.dummyList.then((value) {
      order = value.sublist(0, 5);
      update();
    });
    salesAnalyticsData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 43, secondSeriesYValue: 37, thirdSeriesYValue: 41),
      ChartSampleData(x: 'Feb', y: 45, secondSeriesYValue: 37, thirdSeriesYValue: 45),
      ChartSampleData(x: 'Mar', y: 50, secondSeriesYValue: 39, thirdSeriesYValue: 48),
      ChartSampleData(x: 'Apr', y: 55, secondSeriesYValue: 43, thirdSeriesYValue: 52),
      ChartSampleData(x: 'May', y: 63, secondSeriesYValue: 48, thirdSeriesYValue: 57),
      ChartSampleData(x: 'Jun', y: 68, secondSeriesYValue: 54, thirdSeriesYValue: 61),
      ChartSampleData(x: 'Jul', y: 72, secondSeriesYValue: 57, thirdSeriesYValue: 66),
      ChartSampleData(x: 'Aug', y: 70, secondSeriesYValue: 57, thirdSeriesYValue: 66),
      ChartSampleData(x: 'Sep', y: 66, secondSeriesYValue: 54, thirdSeriesYValue: 63),
      ChartSampleData(x: 'Oct', y: 57, secondSeriesYValue: 48, thirdSeriesYValue: 55),
      ChartSampleData(x: 'Nov', y: 50, secondSeriesYValue: 43, thirdSeriesYValue: 50),
      ChartSampleData(x: 'Dec', y: 45, secondSeriesYValue: 37, thirdSeriesYValue: 45)
    ];
    super.onInit();
  }

  final List<ChartSampleData> chartData = [
    ChartSampleData(x: 'Jan', y: 10, yValue: 1000),
    ChartSampleData(x: 'Fab', y: 20, yValue: 2000),
    ChartSampleData(x: 'Mar', y: 15, yValue: 1500),
    ChartSampleData(x: 'Jun', y: 5, yValue: 500),
    ChartSampleData(x: 'Jul', y: 30, yValue: 3000),
    ChartSampleData(x: 'Aug', y: 20, yValue: 2000),
    ChartSampleData(x: 'Sep', y: 40, yValue: 4000),
    ChartSampleData(x: 'Oct', y: 60, yValue: 6000),
    ChartSampleData(x: 'Nov', y: 55, yValue: 5500),
    ChartSampleData(x: 'Dec', y: 38, yValue: 3000),
  ];
  final TooltipBehavior chart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );

  final List<ChartSampleData> circleChart = [
    ChartSampleData(x: 'David', y: 25, pointColor: const Color.fromRGBO(9, 0, 136, 1)),
    ChartSampleData(x: 'Steve', y: 38, pointColor: const Color.fromRGBO(147, 0, 119, 1)),
    ChartSampleData(x: 'Jack', y: 34, pointColor: const Color.fromRGBO(228, 0, 124, 1)),
    ChartSampleData(x: 'Others', y: 52, pointColor: const Color.fromRGBO(255, 189, 57, 1))
  ];

  void onSelectedTimeByLocation(String time) {
    selectedTimeByLocation = time;
    update();
  }

  @override
  void dispose() {
    salesAnalyticsData!.clear();
    super.dispose();
  }
}
