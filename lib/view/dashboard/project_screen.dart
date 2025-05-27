import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/dashboard/project_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/utils/utils.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_list_extension.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/images.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/model/task_list_model.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> with UIMixin {
  ProjectController controller = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Project", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard'),
                        MyBreadcrumbItem(name: 'Project', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-6', child: stats()),
                  MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: taskPerformance()),
                  MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: incomeAnalytics()),
                  MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: taskList()),
                  MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: recentTransaction()),
                  MyFlexItem(sizes: 'lg-3 md-6', child: taskSummary()),
                  MyFlexItem(sizes: 'lg-9 md-6', child: projectSummary()),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget stats() {
    Widget statsWidget(String title, String subTitle, IconData icon, Color color) {
      return MyCard.bordered(
          borderRadiusAll: 4,
          border: Border.all(color: Colors.grey.withValues(alpha:.2)),
          shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
          paddingAll: 24,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.bodyMedium(title, maxLines: 1),
                      MyText.titleMedium(subTitle, fontWeight: 600),
                    ],
                  ),
                ),
              ),
              MyContainer(
                color: color,
                child: Icon(icon, color: contentTheme.light),
              )
            ],
          ));
    }

    return MyFlex(
      contentPadding: false,
      children: [
        MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget("Projects Completed", "120", LucideIcons.briefcase, contentTheme.primary)),
        MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget("Tasks In Progress", "75", LucideIcons.circle_check, contentTheme.secondary)),
        MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget("Total Hours Worked", "540", LucideIcons.clock, contentTheme.info)),
        MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget("Current Budgets", "\$12,500", LucideIcons.dollar_sign, contentTheme.success)),
        MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget("Completed Tasks", "58", LucideIcons.check, contentTheme.warning)),
        MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget("Team Members", "15", LucideIcons.user, contentTheme.danger)),
      ],
    );
  }

  Widget taskPerformance() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Task Performance", fontWeight: 600),
          SizedBox(
            height: 299,
            child: Theme(
              data: ThemeData(),
              child: SfCircularChart(
                margin: MySpacing.zero,
                series: [
                  RadialBarSeries<ChartSampleData, String>(
                      dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 10.0)),
                      dataSource: <ChartSampleData>[
                        ChartSampleData(x: 'Complete', y: 7, text: '100%', pointColor: contentTheme.primary),
                        ChartSampleData(x: 'Active', y: 5, text: '100%', pointColor: contentTheme.success),
                        ChartSampleData(x: 'Assigned', y: 8, text: '100%', pointColor: contentTheme.info),
                      ],
                      trackColor: contentTheme.background,
                      cornerStyle: CornerStyle.bothCurve,
                      gap: '10%',
                      radius: '90%',
                      xValueMapper: (ChartSampleData data, _) => data.x as String,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                      pointRadiusMapper: (ChartSampleData data, _) => data.text,
                      pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                      dataLabelMapper: (ChartSampleData data, _) => data.x as String)
                ],
                tooltipBehavior: controller.tooltipBehavior,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget incomeAnalytics() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Income Analytics", fontWeight: 600),
          SfCircularChart(
            margin: MySpacing.zero,
            legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            series: [
              PieSeries<ChartSampleData, String>(
                dataSource: <ChartSampleData>[
                  ChartSampleData(x: 'USA', y: 700000, text: '60%'),
                  ChartSampleData(x: 'Germany', y: 450000, text: '50%'),
                  ChartSampleData(x: 'China', y: 600000, text: '65%'),
                  ChartSampleData(x: 'India', y: 400000, text: '55%'),
                  ChartSampleData(x: 'Brazil', y: 350000, text: '40%'),
                  ChartSampleData(x: 'Russia', y: 300000, text: '35%'),
                  ChartSampleData(x: 'South Africa', y: 250000, text: '30%')
                ],
                xValueMapper: (ChartSampleData data, _) => data.x as String,
                yValueMapper: (ChartSampleData data, _) => data.y,
                dataLabelMapper: (ChartSampleData data, _) => data.x as String,
                startAngle: 100,
                endAngle: 100,
                pointRadiusMapper: (ChartSampleData data, _) => data.text,
                dataLabelSettings: const DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.auto, duration: 2 * 1000),
          )
        ],
      ),
    );
  }

  Widget taskList() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.all(24),
            child: MyText.bodyMedium("Task List", fontWeight: 600),
          ),
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: controller.task.length,
              shrinkWrap: true,
              padding: MySpacing.x(24),
              itemBuilder: (context, index) {
                TaskListModel task = controller.task[index];
                return Row(
                  children: [
                    Theme(
                      data: ThemeData(visualDensity: getCompactDensity),
                      child: Checkbox(
                        value: task.isSelectTask,
                        onChanged: (value) => controller.onSelectTask(task),
                        visualDensity: getCompactDensity,
                      ),
                    ),
                    MySpacing.width(12),
                    MyContainer.rounded(
                      height: 32,
                      width: 32,
                      paddingAll: 0,
                      child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                    ),
                    MySpacing.width(12),
                    Expanded(child: MyText.bodyMedium(task.title, maxLines: 1)),
                    MyText.labelMedium(task.status,
                        color: task.status == 'Pending'
                            ? contentTheme.primary
                            : task.status == 'Completed'
                                ? contentTheme.success
                                : null),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return MySpacing.height(24);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget recentTransaction() {
    Widget recentTransaction(String title, String subTitle, String price) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyContainer.roundBordered(
                paddingAll: 12,
                child: MyText(title[0].capitalize.toString()),
              ),
              MySpacing.width(24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(title),
                    MySpacing.height(4),
                    MyText.bodySmall(subTitle),
                  ],
                ),
              ),
              MyText.bodySmall(price),
            ],
          )
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 0,
      height: 367,
      child: ListView(
        padding: MySpacing.all(24),
        children: [
          MyText.bodyMedium("Recent Transaction", fontWeight: 600),
          MySpacing.height(24),
          recentTransaction("Charles", "Feb 28,2023 - 12:54PM", "price"),
          MySpacing.height(24),
          recentTransaction("David", "Feb 28,2023 - 12:54PM", "price"),
          MySpacing.height(24),
          recentTransaction("Leonard", "Feb 28,2023 - 12:54PM", "price"),
          MySpacing.height(24),
          recentTransaction("Steven", "Feb 28,2023 - 12:54PM", "price"),
          MySpacing.height(24),
          recentTransaction("Steven", "Feb 28,2023 - 12:54PM", "price"),
        ],
      ),
    );
  }

  Widget taskSummary() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium("Task Summary", fontWeight: 600),
              MyContainer(
                onTap: () {},
                paddingAll: 8,
                color: contentTheme.light,
                child: MyText.labelSmall("View All", fontWeight: 600),
              )
            ],
          ),
          MySpacing.height(24),
          SizedBox(
            height: 344,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: MySpacing.zero,
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              primaryXAxis: const CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
              primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(width: 0), edgeLabelPlacement: EdgeLabelPlacement.shift, labelFormat: '{value}', majorTickLines: MajorTickLines(size: 0)),
              series: [
                SplineSeries<ChartSampleData, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: 'This Week'),
                SplineSeries<ChartSampleData, String>(
                  dataSource: controller.chartData,
                  name: 'Last Week',
                  markerSettings: const MarkerSettings(isVisible: true),
                  xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                  yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
                )
              ],
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          )
        ],
      ),
    );
  }

  Widget projectSummary() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Project Summary", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 84,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge('S.No', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Title', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Assign to', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Due Date', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Priority', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                ],
                rows: controller.projectSummary
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.bodyMedium("#${data.id}", fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.title, fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.assignTo, fontWeight: 600)),
                          DataCell(MyText.bodyMedium(Utils.getDateStringFromDateTime(data.date), fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.priority, fontWeight: 600)),
                          DataCell(MyText.bodyMedium(data.status, fontWeight: 600)),
                          DataCell(Row(
                            children: [
                              MyContainer(
                                onTap: () {},
                                color: contentTheme.primary,
                                paddingAll: 8,
                                child: Icon(LucideIcons.download, size: 16, color: contentTheme.onPrimary),
                              ),
                              MySpacing.width(12),
                              MyContainer(
                                onTap: () {},
                                color: contentTheme.secondary,
                                paddingAll: 8,
                                child: Icon(LucideIcons.pencil, size: 16, color: contentTheme.onPrimary),
                              ),
                            ],
                          ))
                        ]))
                    .toList()),
          )
        ],
      ),
    );
  }
}
