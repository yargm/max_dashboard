import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/dashboard/job_controller.dart';
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
import 'package:maxdash/view/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> with UIMixin {
  JobController controller = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'job_dashboard_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Job", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard'),
                        MyBreadcrumbItem(name: 'Job', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                  padding: MySpacing.x(flexSpacing / 2),
                  child: MyFlex(
                    children: [
                      MyFlexItem(sizes: 'xxl-2 xl-4 lg-4 md-4 sm-6', child: stats(LucideIcons.briefcase, '245', 'EMPLOYEES IN SYSTEM', contentTheme.primary)),
                      MyFlexItem(sizes: 'xxl-2 xl-4 lg-4 md-4 sm-6', child: stats(LucideIcons.file_text, '3201', 'CANDIDATES IN DATA', contentTheme.secondary)),
                      MyFlexItem(sizes: 'xxl-2 xl-4 lg-4 md-4 sm-6', child: stats(LucideIcons.map_pin, '56', 'LOCATIONS SERVED', contentTheme.success)),
                      MyFlexItem(sizes: 'xxl-2 xl-4 lg-4 md-4 sm-6', child: stats(LucideIcons.user_plus, '312', 'RECRUITER NETWORK', contentTheme.info)),
                      MyFlexItem(sizes: 'xxl-2 xl-4 lg-4 md-4 sm-6', child: stats(LucideIcons.credit_card, '689', 'ACTIVE SUBSCRIPTIONS', contentTheme.purple)),
                      MyFlexItem(sizes: 'xxl-2 xl-4 lg-4 md-4 sm-6', child: stats(LucideIcons.cloud_upload, '82%', 'RESUME UPLOAD RATE', contentTheme.pink)),
                      MyFlexItem(sizes: 'lg-4', child: workingFormat()),
                      MyFlexItem(sizes: 'lg-8 md-6', child: listingPerformance()),
                      MyFlexItem(sizes: 'lg-4 md-6', child: recentCandidate()),
                      MyFlexItem(sizes: 'lg-4 md-6', child: mostViewedCVs()),
                      MyFlexItem(sizes: 'lg-4 md-6', child: recentChat()),
                      MyFlexItem(child: recentApplication()),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget stats(IconData? icon, String title, String subTitle, Color color) {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Row(
        children: [
          MyContainer(
            paddingAll: 12,
            color: color,
            child: Icon(icon, color: contentTheme.light, size: 16),
          ),
          MySpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleMedium(title, fontWeight: 600),
                MySpacing.height(4),
                MyText.labelSmall(subTitle, xMuted: true, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget workingFormat() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 408,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyText.bodyMedium("Working Format", height: .8, fontWeight: 600),
        SfCircularChart(legend: Legend(isVisible: true, position: LegendPosition.bottom, overflowMode: LegendItemOverflowMode.wrap), series: [
          DoughnutSeries<ChartSampleData, String>(
              explode: true,
              dataSource: <ChartSampleData>[
                ChartSampleData(x: 'OnSite', y: 55, text: '55%'),
                ChartSampleData(x: 'Remote', y: 31, text: '31%'),
                ChartSampleData(x: 'Hybrid', y: 7.7, text: '7.7%'),
              ],
              xValueMapper: (ChartSampleData data, _) => data.x as String,
              yValueMapper: (ChartSampleData data, _) => data.y,
              dataLabelMapper: (ChartSampleData data, _) => data.text,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ])
      ]),
    );
  }

  Widget listingPerformance() {
    Widget isSelectTime(String title, int index) {
      bool isSelect = controller.isSelectedListingPerformanceTime == index;
      return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 0, position: MyShadowPosition.bottom),
        paddingAll: 4,
        color: isSelect ? contentTheme.secondary.withValues(alpha:0.15) : null,
        onTap: () => controller.onSelectListingPerformanceTimeToggle(index),
        child: MyText.labelSmall(title, fontWeight: 600, color: isSelect ? contentTheme.secondary : null),
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MyText.bodyMedium("Listing Performance", fontWeight: 600, overflow: TextOverflow.ellipsis),
              ),
              isSelectTime("Day", 0),
              MySpacing.width(12),
              isSelectTime("Week", 1),
              MySpacing.width(12),
              isSelectTime("Month", 2),
            ],
          ),
          MySpacing.height(24),
          SizedBox(
            height: 310,
            child: SfCartesianChart(
                margin: MySpacing.zero,
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
                primaryYAxis: NumericAxis(
                  maximum: 20,
                  minimum: 0,
                  interval: 4,
                  axisLine: AxisLine(width: 0),
                  majorTickLines: MajorTickLines(size: 0),
                ),
                series: [
                  ColumnSeries<ChartSampleData, String>(
                      width: .7,
                      spacing: .2,
                      dataSource: controller.chartData,
                      color: theme.colorScheme.primary,
                      xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                      yValueMapper: (ChartSampleData sales, _) => sales.y,
                      name: 'Views'),
                  ColumnSeries<ChartSampleData, String>(
                      dataSource: controller.chartData,
                      width: .7,
                      spacing: .2,
                      color: theme.colorScheme.secondary,
                      xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                      yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
                      name: 'Application')
                ],
                legend: Legend(isVisible: true, position: LegendPosition.bottom),
                tooltipBehavior: controller.columnToolTip),
          )
        ],
      ),
    );
  }

  Widget recentCandidate() {
    Widget candidatesData(String image, title, subtitle) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600),
                MyText.bodySmall(subtitle, fontWeight: 600, xMuted: true, maxLines: 1, overflow: TextOverflow.visible)
              ],
            ),
          )
        ],
      );
    }

    return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Recent Candidate", fontWeight: 600),
            MySpacing.height(24),
            candidatesData(Images.avatars[3], "Sophia Williams", controller.dummyTexts[0]),
            MySpacing.height(24),
            candidatesData(Images.avatars[4], "Ethan Johnson", controller.dummyTexts[1]),
            MySpacing.height(24),
            candidatesData(Images.avatars[5], "Olivia Martinez", controller.dummyTexts[2]),
            MySpacing.height(24),
            candidatesData(Images.avatars[6], "Liam Brown", controller.dummyTexts[3]),
            MySpacing.height(24),
            candidatesData(Images.avatars[7], "Ava Davis", controller.dummyTexts[4]),
            MySpacing.height(24),
            candidatesData(Images.avatars[8], "Mason Lee", controller.dummyTexts[5]),
          ],
        ));
  }

  Widget mostViewedCVs() {
    Widget cv(String title) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: contentTheme.primary.withAlpha(40),
            child: Icon(LucideIcons.file_text, color: contentTheme.primary),
          ),
          MySpacing.width(12),
          Expanded(child: MyText.bodyMedium(title, fontWeight: 600, overflow: TextOverflow.ellipsis)),
          InkWell(onTap: () {}, child: Icon(LucideIcons.download))
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Most Viewed CV's", fontWeight: 600),
          MySpacing.height(24),
          cv("Isabella Green"),
          MySpacing.height(24),
          cv("James Turner"),
          MySpacing.height(24),
          cv("Charlotte Scott"),
          MySpacing.height(24),
          cv("Oliver King"),
          MySpacing.height(24),
          cv("Lucas Carter"),
          MySpacing.height(24),
          cv("Mia Brooks"),
        ],
      ),
    );
  }

  Widget recentChat() {
    Widget chat(String image, name, message) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(name, fontWeight: 600),
              MyText.labelSmall(message, fontWeight: 600, maxLines: 1, muted: true, overflow: TextOverflow.ellipsis),
            ],
          )),
          MySpacing.width(28),
          Icon(LucideIcons.message_square, size: 20)
        ],
      );
    }

    return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 24,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MyText.bodyMedium("Recent Chat", fontWeight: 600),
          MySpacing.height(24),
          chat(Images.avatars[0], "Sophia", controller.dummyTexts[6]),
          MySpacing.height(24),
          chat(Images.avatars[1], "Liam", controller.dummyTexts[5]),
          MySpacing.height(24),
          chat(Images.avatars[2], "Charlotte", controller.dummyTexts[4]),
          MySpacing.height(24),
          chat(Images.avatars[3], "Oliver", controller.dummyTexts[3]),
          MySpacing.height(24),
          chat(Images.avatars[4], "Amelia", controller.dummyTexts[2]),
          MySpacing.height(24),
          chat(Images.avatars[5], "James", controller.dummyTexts[1])
        ]));
  }

  Widget recentApplication() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Recent Application", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 88,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge('S.No', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Candidate', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Category', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Designation', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Mail', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Location', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Type', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                ],
                rows: controller.recentApplication
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.bodyMedium("#${data.id}", fontWeight: 600)),
                          DataCell(Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyContainer(
                                height: 40,
                                width: 40,
                                paddingAll: 0,
                                child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                              ),
                              MySpacing.width(24),
                              MyText.labelMedium(data.candidate, fontWeight: 600)
                            ],
                          )),
                          DataCell(MyText.labelMedium(data.category, fontWeight: 600)),
                          DataCell(MyText.labelMedium(data.designation, fontWeight: 600)),
                          DataCell(MyText.labelMedium(data.mail, fontWeight: 600)),
                          DataCell(MyText.labelMedium(data.location, fontWeight: 600)),
                          DataCell(MyText.labelMedium("${Utils.getDateStringFromDateTime(data.date)}", fontWeight: 600)),
                          DataCell(MyText.labelMedium(data.type, fontWeight: 600)),
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
