import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/project_summary_model.dart';
import 'package:maxdash/model/task_list_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectController extends MyController {
  TooltipBehavior? tooltipBehavior;
  List<TaskListModel> task = [];
  List<ProjectSummaryModel> projectSummary = [];
  List<ChartSampleData>? chartData;

  @override
  void onInit() {
    TaskListModel.dummyList.then((value) {
      task = value;
      update();
    });
    ProjectSummaryModel.dummyList.then((value) {
      projectSummary = value.sublist(0, 5);
      update();
    });
    chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 10, secondSeriesYValue: 8, thirdSeriesYValue: 12),
      ChartSampleData(x: 'Feb', y: 5, secondSeriesYValue: 6, thirdSeriesYValue: 7),
      ChartSampleData(x: 'Mar', y: 11, secondSeriesYValue: 9, thirdSeriesYValue: 6),
      ChartSampleData(x: 'Apr', y: 14, secondSeriesYValue: 10, thirdSeriesYValue: 13),
      ChartSampleData(x: 'May', y: 9, secondSeriesYValue: 7, thirdSeriesYValue: 5),
      ChartSampleData(x: 'Jun', y: 8, secondSeriesYValue: 12, thirdSeriesYValue: 11),
      ChartSampleData(x: 'Jul', y: 12, secondSeriesYValue: 11, thirdSeriesYValue: 9),
      ChartSampleData(x: 'Aug', y: 7, secondSeriesYValue: 13, thirdSeriesYValue: 10),
      ChartSampleData(x: 'Sep', y: 6, secondSeriesYValue: 5, thirdSeriesYValue: 8),
      ChartSampleData(x: 'Oct', y: 4, secondSeriesYValue: 14, thirdSeriesYValue: 15),
      ChartSampleData(x: 'Nov', y: 13, secondSeriesYValue: 4, thirdSeriesYValue: 11),
      ChartSampleData(x: 'Dec', y: 15, secondSeriesYValue: 3, thirdSeriesYValue: 4)
    ];

    tooltipBehavior = TooltipBehavior(enable: true, format: 'point.x : point.ym');
    super.onInit();
  }

  void onSelectTask(TaskListModel task) {
    task.isSelectTask = !task.isSelectTask;
    update();
  }
}
