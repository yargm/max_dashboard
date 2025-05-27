import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/recent_order_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesController extends MyController {
  List<ChartData>? statisticsData;
  List<RecentOrderModel> recentOrder = [];

  @override
  void onInit() {
    RecentOrderModel.dummyList.then((value) {
      recentOrder = value;
      update();
    });

    statisticsData = <ChartData>[
      ChartData(2005, 15, 25),
      ChartData(2006, 40, 55),
      ChartData(2007, 50, 70),
      ChartData(2008, 55, 80),
      ChartData(2009, 65, 85),
      ChartData(2010, 70, 95),
      ChartData(2011, 90, 110)
    ];
    super.onInit();
  }

  final List<ChartSampleData> visitorChartData = [
    ChartSampleData(x: 'Jan', y: 12, yValue: 1200),
    ChartSampleData(x: 'Feb', y: 18, yValue: 1800),
    ChartSampleData(x: 'Mar', y: 22, yValue: 2200),
    ChartSampleData(x: 'Apr', y: 10, yValue: 1000),
    ChartSampleData(x: 'May', y: 25, yValue: 2500),
    ChartSampleData(x: 'Jun', y: 35, yValue: 3500),
    ChartSampleData(x: 'Jul', y: 28, yValue: 2800),
    ChartSampleData(x: 'Aug', y: 45, yValue: 4500),
    ChartSampleData(x: 'Sep', y: 50, yValue: 5000),
    ChartSampleData(x: 'Oct', y: 60, yValue: 6000),
    ChartSampleData(x: 'Nov', y: 42, yValue: 4200),
    ChartSampleData(x: 'Dec', y: 55, yValue: 5500),
  ];

  final TooltipBehavior visitorChart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );
}

class ChartData {
  ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
