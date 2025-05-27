import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/coin_growth_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoController extends MyController {
  List<ChartSampleData>? chartData;
  DateTimeIntervalType intervalType = DateTimeIntervalType.months;
  List<CoinGrowthModel> coinGrowth = [];

  bool enableSolidCandle = false;

  TrackballBehavior? trackballBehavior;

  @override
  void onInit() {
    CoinGrowthModel.dummyList.then((value) {
      coinGrowth = value.sublist(0, 5);
      update();
    });
    chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 50, secondSeriesYValue: 40, thirdSeriesYValue: 45),
      ChartSampleData(x: 'Feb', y: 47, secondSeriesYValue: 39, thirdSeriesYValue: 48),
      ChartSampleData(x: 'Mar', y: 55, secondSeriesYValue: 42, thirdSeriesYValue: 50),
      ChartSampleData(x: 'Apr', y: 60, secondSeriesYValue: 45, thirdSeriesYValue: 53),
      ChartSampleData(x: 'May', y: 70, secondSeriesYValue: 50, thirdSeriesYValue: 58),
      ChartSampleData(x: 'Jun', y: 75, secondSeriesYValue: 55, thirdSeriesYValue: 62),
      ChartSampleData(x: 'Jul', y: 80, secondSeriesYValue: 58, thirdSeriesYValue: 65),
      ChartSampleData(x: 'Aug', y: 78, secondSeriesYValue: 60, thirdSeriesYValue: 66),
      ChartSampleData(x: 'Sep', y: 72, secondSeriesYValue: 55, thirdSeriesYValue: 64),
      ChartSampleData(x: 'Oct', y: 65, secondSeriesYValue: 50, thirdSeriesYValue: 57),
      ChartSampleData(x: 'Nov', y: 58, secondSeriesYValue: 45, thirdSeriesYValue: 53),
      ChartSampleData(x: 'Dec', y: 50, secondSeriesYValue: 40, thirdSeriesYValue: 48)
    ];

    super.onInit();
  }

  void onSelectIntervalType(DateTimeIntervalType interval) {
    intervalType = interval;
    update();
  }
}
