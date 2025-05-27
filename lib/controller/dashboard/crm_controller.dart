import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/lead_report_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CrmController extends MyController {
  List<ChartSampleData>? chartData;
  List<LeadReportModel> leadReport = [];
  TooltipBehavior? tooltipBehavior;

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 10, secondSeriesYValue: 5),
      ChartSampleData(x: 'Feb', y: 12, secondSeriesYValue: 8),
      ChartSampleData(x: 'Mar', y: 14, secondSeriesYValue: 9),
      ChartSampleData(x: 'Apr', y: 11, secondSeriesYValue: 7),
      ChartSampleData(x: 'May', y: 15, secondSeriesYValue: 10),
      ChartSampleData(x: 'Jun', y: 9, secondSeriesYValue: 6),
      ChartSampleData(x: 'Jul', y: 13, secondSeriesYValue: 7),
      ChartSampleData(x: 'Aug', y: 12, secondSeriesYValue: 8),
      ChartSampleData(x: 'Sep', y: 14, secondSeriesYValue: 10),
      ChartSampleData(x: 'Oct', y: 15, secondSeriesYValue: 12),
      ChartSampleData(x: 'Nov', y: 13, secondSeriesYValue: 9),
      ChartSampleData(x: 'Dec', y: 11, secondSeriesYValue: 6),
    ];

    LeadReportModel.dummyList.then((value) {
      leadReport = value.sublist(0, 5);
      update();
    });
    super.onInit();
  }
}
