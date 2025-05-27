import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/helpers/widgets/my_text_utils.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/job_recent_application_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class JobController extends MyController {
  int isSelectedListingPerformanceTime = 0;
  List<ChartSampleData>? chartData;
  TooltipBehavior? columnToolTip;
  List<JobRecentApplicationModel> recentApplication = [];
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 4, secondSeriesYValue: 8),
      ChartSampleData(x: 'Feb', y: 9, secondSeriesYValue: 7),
      ChartSampleData(x: 'Mar', y: 6, secondSeriesYValue: 5),
      ChartSampleData(x: 'Apr', y: 8, secondSeriesYValue: 3),
      ChartSampleData(x: 'May', y: 7, secondSeriesYValue: 9),
      ChartSampleData(x: 'Jun', y: 10, secondSeriesYValue: 6),
      ChartSampleData(x: 'Jul', y: 5, secondSeriesYValue: 4),
      ChartSampleData(x: 'Aug', y: 3, secondSeriesYValue: 2),
      ChartSampleData(x: 'Sep', y: 6, secondSeriesYValue: 10),
      ChartSampleData(x: 'Oct', y: 4, secondSeriesYValue: 8),
      ChartSampleData(x: 'Nov', y: 9, secondSeriesYValue: 6),
      ChartSampleData(x: 'Dec', y: 7, secondSeriesYValue: 5),
    ];
    columnToolTip = TooltipBehavior(enable: true);
    JobRecentApplicationModel.dummyList.then((value) {
      recentApplication = value.sublist(0, 5);
      update();
    });
    super.onInit();
  }

  void onSelectListingPerformanceTimeToggle(index) {
    isSelectedListingPerformanceTime = index;
    update();
  }
}
