import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/dashboard/analytics_controller.dart';
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
import 'package:maxdash/helpers/widgets/my_progress_bar.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/images.dart';
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with UIMixin {
  AnalyticsController controller = Get.put(AnalyticsController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'analytics_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Analytics", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard'),
                        MyBreadcrumbItem(name: 'Analytics', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-2.4 md-6 sm-6', child: stats("Pending", "1.245", "5.12%", LucideIcons.clock)),
                  MyFlexItem(sizes: 'lg-2.4 md-6 sm-6', child: stats("Paid", "92.342", "67.89%", LucideIcons.circle_check)),
                  MyFlexItem(sizes: 'lg-2.4 md-4 sm-4', child: stats("Rejected", "12.367", "3.56%", LucideIcons.circle_x)),
                  MyFlexItem(sizes: 'lg-2.4 md-4 sm-4', child: stats("In Progress", "5.125", "10.78%", LucideIcons.hourglass)),
                  MyFlexItem(sizes: 'lg-2.4 md-4 sm-4', child: stats("Canceled", "7.489", "4.45%", LucideIcons.trash)),
                  MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: activityOnThePage()),
                  MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: audienceOverview()),
                  MyFlexItem(sizes: 'lg-4 md-12', child: buildTrafficSources()),
                  MyFlexItem(sizes: 'lg-4 md-6 sm-6', child: buildMostActiveUser()),
                  MyFlexItem(sizes: 'lg-4 md-6 sm-6', child: buildVisitorsByCountry()),
                  MyFlexItem(child: buildVisitorByChannel()),
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  Widget stats(String title, String subTitle, String percentage, IconData icon) {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Padding(
            padding: MySpacing.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodySmall(title, maxLines: 1),
                      MySpacing.height(4),
                      MyText.titleLarge(subTitle, maxLines: 1),
                    ],
                  ),
                ),
                MyContainer(
                  color: contentTheme.secondary.withValues(alpha:0.2),
                  paddingAll: 12,
                  child: Icon(icon, size: 16, color: contentTheme.onBackground),
                )
              ],
            ),
          ),
          MyContainer(
            color: contentTheme.background,
            borderRadiusAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: [
                Icon(LucideIcons.arrow_up_right, size: 16),
                MySpacing.width(8),
                MyText.labelMedium(percentage),
                MySpacing.width(8),
                Expanded(child: MyText.labelMedium("Last Month", muted: true, maxLines: 1)),
                Expanded(child: InkWell(onTap: () {}, child: MyText.labelMedium("View More", fontWeight: 600, maxLines: 1))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget activityOnThePage() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyText.bodyMedium("Activity on the pages", fontWeight: 600, overflow: TextOverflow.ellipsis),
              ),
              PopupMenuButton(
                onSelected: controller.onSelectedActivity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemBuilder: (BuildContext context) {
                  return ["Year", "Month", "Week", "Day", "Hours"].map((behavior) {
                    return PopupMenuItem(
                      value: behavior,
                      height: 32,
                      child: MyText.bodySmall(
                        behavior.toString(),
                        color: theme.colorScheme.onSurface,
                        fontWeight: 600,
                      ),
                    );
                  }).toList();
                },
                color: theme.cardTheme.color,
                child: MyContainer.bordered(
                  padding: MySpacing.xy(8, 4),
                  borderRadiusAll: 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyText.bodySmall(
                        controller.selectActivity.toString(),
                        fontWeight: 600,
                        color: theme.colorScheme.onSurface,
                      ),
                      MySpacing.width(4),
                      Icon(
                        LucideIcons.chevron_down,
                        size: 20,
                        color: theme.colorScheme.onSurface,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          MySpacing.height(24),
          SizedBox(
            height: 305,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
              tooltipBehavior: controller.columnChartToolTip,
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              series: [
                ColumnSeries<ChartSampleData, int>(
                    opacity: 0.9,
                    width: 0.6,
                    color: contentTheme.title,
                    dataSource: controller.columnChart,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
                ColumnSeries<ChartSampleData, int>(
                  color: contentTheme.success,
                  dataSource: controller.columnChart,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.yValue,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget audienceOverview() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Audience Overview", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(
              height: 318,
              child: SfCartesianChart(tooltipBehavior: controller.audienceOverview, series: <CartesianSeries>[
                BarSeries<ChartSampleData, dynamic>(
                    color: Colors.blue,
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                    dataSource: controller.audienceOverviewChart,
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    width: 0.6,
                    spacing: 0.3),
                BarSeries<ChartSampleData, dynamic>(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                    dataSource: controller.audienceOverviewChart,
                    color: Colors.teal,
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.yValue,
                    width: 0.6,
                    spacing: 0.3)
              ]))
        ],
      ),
    );
  }

  Widget buildTrafficSources() {
    Widget buildData(String browser, session, double process) {
      return Row(
        children: [
          Expanded(child: MyText.bodyMedium(browser, fontWeight: 600, overflow: TextOverflow.ellipsis)),
          Expanded(
            child: Row(
              children: [
                if (session >= 5000) Icon(LucideIcons.trending_up, size: 20, color: contentTheme.success),
                if (session < 5000) Icon(LucideIcons.trending_down, size: 20, color: contentTheme.danger),
                MySpacing.width(8),
                Expanded(
                  child: MyText.bodyMedium("$session", fontWeight: 600, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(
            child: MyProgressBar(
              progress: process,
              height: 4,
              radius: 4,
              inactiveColor: theme.dividerColor,
              activeColor: contentTheme.primary,
            ),
          ),
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.only(left: 23, top: 19),
            child: MyText.titleMedium("Traffic Sources", fontWeight: 600),
          ),
          MySpacing.height(24),
          Divider(height: 0),
          MySpacing.height(24),
          Padding(
            padding: MySpacing.only(left: 23),
            child: Row(children: [
              Expanded(child: MyText.bodyMedium("Browser", fontWeight: 600)),
              Expanded(child: MyText.bodyMedium("Sessions", fontWeight: 600)),
              Expanded(child: MyText.bodyMedium("Traffic", fontWeight: 600)),
            ]),
          ),
          MySpacing.height(24),
          Divider(height: 0),
          Padding(
            padding: MySpacing.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildData("Google Chrome", 12000, .30),
                MySpacing.height(24),
                buildData("Apple Safari", 7000, .25),
                MySpacing.height(24),
                buildData("Microsoft Edge", 4500, .15),
                MySpacing.height(24),
                buildData("Mozilla Firefox", 8000, .22),
                MySpacing.height(24),
                buildData("Opera Browser", 3000, .18),
                MySpacing.height(24),
                buildData("Brave Browser", 2000, .12),
                MySpacing.height(24),
                buildData("Vivaldi Browser", 1500, .08),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMostActiveUser() {
    Widget buildData(String image, name, emailID) {
      return MyContainer.bordered(
        child: Row(
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
                  MyText.bodyMedium(name, fontWeight: 600),
                  MySpacing.height(4),
                  MyText.labelMedium(
                    emailID,
                    fontWeight: 600,
                    xMuted: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
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
            MyText.titleMedium("Most Active user", fontWeight: 600),
            MySpacing.height(20),
            SizedBox(
              height: 372,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildData(Images.avatars[0], "John Doe", "john.doe@example.com"),
                    MySpacing.height(24),
                    buildData(Images.avatars[1], "Emily Smith", "emily.smith@example.com"),
                    MySpacing.height(24),
                    buildData(Images.avatars[2], "Michael Johnson", "michael.johnson@example.com"),
                    MySpacing.height(24),
                    buildData(Images.avatars[3], "Olivia Williams", "olivia.williams@example.com"),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildVisitorsByCountry() {
    Widget buildData(String image, name, count) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 41,
            width: 41,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          MySpacing.width(12),
          Expanded(
            child: MyText.bodyMedium(name, fontWeight: 600, overflow: TextOverflow.ellipsis),
          ),
          MyContainer(
            borderRadiusAll: 8,
            padding: MySpacing.xy(8, 8),
            color: Colors.brown.withAlpha(36),
            child: MyText.bodySmall(
              numberFormatter(count),
              fontWeight: 600,
              color: Colors.brown,
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
          MyText.titleMedium("Visitor by country's", fontWeight: 600),
          MySpacing.height(24),
          buildData('assets/country/united_states.png', "United State", "41560"),
          MySpacing.height(24),
          buildData('assets/country/argentina.png', "Argentina", "18400"),
          MySpacing.height(24),
          buildData('assets/country/germany.png', "Germany", "9000"),
          MySpacing.height(24),
          buildData('assets/country/mexico.png', "Mexico", "15325"),
          MySpacing.height(24),
          buildData('assets/country/russia.png', "Russia", "12222"),
          MySpacing.height(24),
          buildData('assets/country/canada.png', "Canada", "2040"),
        ],
      ),
    );
  }

  Widget buildVisitorByChannel() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Visitors By Channel", fontWeight: 600),
          MySpacing.height(24),
          if (controller.visitorByChannel.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 105,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 60,
                  showBottomBorder: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                  columns: [
                    DataColumn(label: MyText.labelLarge('S.No', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Channel', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Session', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Bounce Rate', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Session Duration', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Target Reached', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Page Per Session', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                  ],
                  rows: controller.visitorByChannel
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(MyText.bodyMedium('${data.id}')),
                            DataCell(MyText.labelLarge(data.channel, overflow: TextOverflow.ellipsis, maxLines: 1)),
                            DataCell(MyText.bodySmall('${data.session}', fontWeight: 600)),
                            DataCell(MyText.bodySmall('${data.bounceRate}%', fontWeight: 600)),
                            DataCell(MyText.bodySmall('${Utils.getDateTimeStringFromDateTime(data.sessionDuration)}', fontWeight: 600)),
                            DataCell(
                              MyContainer(
                                borderRadiusAll: 4,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                padding: MySpacing.xy(8, 8),
                                color: contentTheme.primary.withAlpha(32),
                                child: MyText.bodySmall('${data.targetReached}', fontWeight: 600, color: contentTheme.primary),
                              ),
                            ),
                            DataCell(MyText.bodyMedium('${data.pagePerSession}')),
                            DataCell(SizedBox(
                              width: 130,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyContainer(
                                    onTap: () => {},
                                    padding: MySpacing.xy(8, 8),
                                    color: contentTheme.primary.withAlpha(36),
                                    child: Icon(LucideIcons.pencil, size: 14, color: contentTheme.primary),
                                  ),
                                  MyContainer(
                                    onTap: () => {},
                                    padding: MySpacing.xy(8, 8),
                                    color: contentTheme.success.withAlpha(36),
                                    child: Icon(LucideIcons.pencil, size: 14, color: contentTheme.success),
                                  ),
                                  MyContainer(
                                    onTap: () => controller.removeData(index),
                                    padding: MySpacing.xy(8, 8),
                                    color: contentTheme.danger.withAlpha(36),
                                    child: Icon(LucideIcons.trash_2, size: 14, color: contentTheme.danger),
                                  ),
                                ],
                              ),
                            )),
                          ]))
                      .toList()),
            ),
        ],
      ),
    );
  }
}
