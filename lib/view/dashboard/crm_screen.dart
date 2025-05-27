import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/dashboard/crm_controller.dart';
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

class CrmScreen extends StatefulWidget {
  const CrmScreen({super.key});

  @override
  State<CrmScreen> createState() => _CrmScreenState();
}

class _CrmScreenState extends State<CrmScreen> with UIMixin {
  CrmController controller = Get.put(CrmController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      tag: 'crm_dashboard_controller',
      builder: (controller) {
        return Layout(
          child: Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Crm", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard'),
                        MyBreadcrumbItem(name: 'Crm', active: true),
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
                    MyFlexItem(
                        sizes: "lg-3 md-6 sm-6",
                        child:
                            stats(LucideIcons.circle_dollar_sign, "Nominal Balance", "\$5,780", "Nominal Balance last month", "\$6,290", contentTheme.primary)),
                    MyFlexItem(
                        sizes: "lg-3 md-6 sm-6",
                        child: stats(LucideIcons.package, "Total Stock Product", "5.264", "Total Stock product last month", "2.546", contentTheme.secondary)),
                    MyFlexItem(
                        sizes: "lg-3 md-6 sm-6",
                        child: stats(LucideIcons.file_down, "Nominal Revenue", "5.264", "Total revenue last month", "2.546", contentTheme.success)),
                    MyFlexItem(
                        sizes: "lg-3 md-6 sm-6",
                        child: stats(LucideIcons.file_up, "Nominal Expenses", "\$19,644", "Total expenses last month", "\$18,946", contentTheme.warning)),
                    MyFlexItem(sizes: 'lg-9', child: revenueForecast()),
                    MyFlexItem(sizes: 'lg-3', child: topDeals()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: dealSource()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: leadResponse()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: openDeals()),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: leadSource()),
                    MyFlexItem(child: leadReport()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget stats(IconData icon, String title, String subTitle, String statsMonthName, String statsMonthRevenue, Color color) {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyContainer.bordered(paddingAll: 8, borderColor: color, child: Icon(icon, size: 16, color: color)),
                MySpacing.width(12),
                MyText.bodyMedium(title, fontWeight: 600),
              ],
            ),
            MyText.titleMedium(subTitle, fontWeight: 600),
            Row(
              children: [
                MyText.labelMedium(statsMonthName, fontWeight: 600, xMuted: true),
                MySpacing.width(8),
                Expanded(child: MyText.labelMedium(statsMonthRevenue, fontWeight: 600, maxLines: 1)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget revenueForecast() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Revenue Forecast", fontWeight: 600),
              PopupMenuButton(
                offset: Offset(0, 20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Download", fontWeight: 600)),
                  PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Import", fontWeight: 600)),
                  PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Export", fontWeight: 600)),
                ],
                child: Icon(LucideIcons.ellipsis_vertical, size: 20),
              )
            ],
          ),
          MySpacing.height(24),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
            ),
            margin: MySpacing.zero,
            primaryYAxis: const NumericAxis(maximum: 20, minimum: 0, interval: 4, axisLine: AxisLine(width: 0), majorTickLines: MajorTickLines(size: 0)),
            series: [
              ColumnSeries<ChartSampleData, String>(
                  width: 0.8,
                  spacing: 0.2,
                  dataSource: controller.chartData,
                  color: contentTheme.primary,
                  xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                  yValueMapper: (ChartSampleData sales, _) => sales.y,
                  name: 'Sales Revenue'),
              ColumnSeries<ChartSampleData, String>(
                  dataSource: controller.chartData,
                  width: 0.8,
                  spacing: 0.2,
                  color: contentTheme.secondary,
                  xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                  yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
                  name: 'Product Cost'),
            ],
            legend: Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: controller.tooltipBehavior,
          )
        ],
      ),
    );
  }

  Widget topDeals() {
    Widget topDealsWidget(String image, String name, String email, String price) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 40,
            width: 40,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(name, fontWeight: 600),
                MyText.labelMedium(email, fontWeight: 600, muted: true, maxLines: 1),
              ],
            ),
          ),
          MyText.labelMedium(price, fontWeight: 600),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Top Deals", fontWeight: 600),
              PopupMenuButton(
                offset: Offset(0, 20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Week", fontWeight: 600)),
                  PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Month", fontWeight: 600)),
                  PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Year", fontWeight: 600)),
                ],
                child: Icon(LucideIcons.ellipsis_vertical, size: 20),
              )
            ],
          ),
          MySpacing.height(24),
          topDealsWidget(Images.avatars[0], "Christopher", "christopher123@gmail.com", "\$14,541"),
          MySpacing.height(24),
          topDealsWidget(Images.avatars[1], "Edward", "edward15@gmail.com", "\$21,548"),
          MySpacing.height(24),
          topDealsWidget(Images.avatars[2], "Michael", "michael@gmail.com", "\$13,645"),
          MySpacing.height(24),
          topDealsWidget(Images.avatars[3], "Sebastian", "sebastian@gmail.com", "\$51,254"),
          MySpacing.height(24),
          topDealsWidget(Images.avatars[4], "Nicholas", "nicholas@gmail.com", "\$15,487"),
        ],
      ),
    );
  }

  Widget dealSource() {
    Widget dealSourceWidget(String image, String title, String subtitle, String totalLeads) {
      return Row(
        children: [
          MyContainer.rounded(
            height: 32,
            width: 32,
            paddingAll: 0,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600),
                MyText.bodySmall(subtitle),
              ],
            ),
          ),
          MyText.labelSmall('$totalLeads Leads', fontWeight: 600),
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
          MyText.bodyMedium("Deal Source", fontWeight: 600),
          MySpacing.height(24),
          dealSourceWidget("assets/social/uxerflow_logo.png", "Website", "userflow.com", "50"),
          MySpacing.height(24),
          dealSourceWidget("assets/social/dribbble-logo.png", "Dribbble", "dribbble.com", "50"),
          MySpacing.height(24),
          dealSourceWidget("assets/social/facebook-logo.png", "Facebook", "facebook.com", "50"),
          MySpacing.height(24),
          dealSourceWidget("assets/social/instagram-logo.png", "Instagram", "instagram.com", "50"),
          MySpacing.height(24),
          dealSourceWidget("assets/social/LinkedIn-logo.png", "Linkedin", "linkedin.com", "50"),
        ],
      ),
    );
  }

  Widget leadResponse() {
    Widget leadData(String image, name, processRate, double progress) {
      return Row(
        children: [
          MyContainer(
            paddingAll: 0,
            height: 32,
            width: 32,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyText.labelLarge(name, fontWeight: 600, overflow: TextOverflow.ellipsis),
                    ),
                    MyText.labelSmall(processRate, fontWeight: 600, overflow: TextOverflow.ellipsis),
                  ],
                ),
                MySpacing.height(8),
                MyProgressBar(
                  width: 300,
                  height: 7,
                  progress: progress,
                  radius: 8,
                  activeColor: contentTheme.primary,
                  inactiveColor: contentTheme.primary.withAlpha(32),
                )
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
          MyText.bodyMedium("Lead Response", fontWeight: 600),
          MySpacing.height(24),
          leadData(Images.avatars[0], "Amelia	Thomson", "1.3", .3),
          MySpacing.height(24),
          leadData(Images.avatars[1], "Ian	Ferguson", "1.4", .4),
          MySpacing.height(24),
          leadData(Images.avatars[2], "Simon	Ross", "2", .8),
          MySpacing.height(24),
          leadData(Images.avatars[3], "Heather", "1.5", .5),
          MySpacing.height(24),
          leadData(Images.avatars[4], "Madeleine Simpson", "1.9", .7),
        ],
      ),
    );
  }

  Widget openDeals() {
    Widget dealsData(String image, dealsType, dealsDate, price) {
      return Row(
        children: [
          MyContainer(
            paddingAll: 0,
            height: 46,
            width: 46,
            borderRadiusAll: 8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(24),
          Expanded(
            child: SizedBox(
              height: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.bodyMedium(dealsType, fontWeight: 600, overflow: TextOverflow.ellipsis),
                  MyText.labelSmall("Closing deal date ${dealsDate}", fontWeight: 600, overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          ),
          MyText.labelMedium("\$${numberFormatter(price)}", fontWeight: 600, color: contentTheme.primary),
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
          MyText.bodyMedium("Open Deals", fontWeight: 600),
          MySpacing.height(24),
          dealsData(Images.avatars[1], "SASS app workflow", "26 Jan", "15478"),
          MySpacing.height(24),
          dealsData(Images.avatars[0], "Create new component", "8 Fab", "54791"),
          MySpacing.height(24),
          dealsData(Images.avatars[3], "New Email Design Template", "16 March", "54876"),
          MySpacing.height(24),
          dealsData(Images.avatars[4], "React Developer", "12 Fab", "1564"),
        ],
      ),
    );
  }

  Widget leadSource() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Lead Source", fontWeight: 600),
          SizedBox(
            height: 280,
            child: SfCircularChart(
              series: [
                PieSeries<ChartSampleData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: <ChartSampleData>[
                      ChartSampleData(x: 'Prospecting', y: 13, text: 'Prospecting \n 13%'),
                      ChartSampleData(x: 'Negotiation', y: 24, text: 'Negotiation \n 24%'),
                      ChartSampleData(x: 'Proposal', y: 25, text: 'Proposal \n 25%'),
                      ChartSampleData(x: 'Qualification', y: 38, text: 'Qualification \n 38%'),
                    ],
                    xValueMapper: (ChartSampleData data, _) => data.x as String,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    dataLabelMapper: (ChartSampleData data, _) => data.text,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget leadReport() {
    return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Lead Report", fontWeight: 600),
            MySpacing.height(24),
            if (controller.leadReport.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    sortAscending: true,
                    columnSpacing: 80,
                    onSelectAll: (_) => {},
                    headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                    dataRowMaxHeight: 60,
                    showBottomBorder: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                    columns: [
                      DataColumn(label: MyText.labelLarge('S.No', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Lead', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Company Name', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Phone Number', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Location', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                      DataColumn(label: MyText.labelLarge('Amount', color: contentTheme.primary)),
                    ],
                    rows: controller.leadReport
                        .mapIndexed((index, data) => DataRow(cells: [
                              DataCell(MyText.bodyMedium("#${data.id}", fontWeight: 600)),
                              DataCell(Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MyContainer(
                                    height: 44,
                                    width: 44,
                                    paddingAll: 0,
                                    child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                                  ),
                                  MySpacing.width(24),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium(data.firstName, fontWeight: 600),
                                      MyText.labelMedium(data.email),
                                    ],
                                  )
                                ],
                              )),
                              DataCell(MyText.bodyMedium(data.companyName, fontWeight: 600)),
                              DataCell(MyText.bodyMedium(data.phoneNumber, fontWeight: 600)),
                              DataCell(MyText.bodyMedium(data.status, fontWeight: 600)),
                              DataCell(MyText.bodyMedium(data.location, fontWeight: 600)),
                              DataCell(MyText.bodyMedium("${Utils.getDateStringFromDateTime(data.date)}", fontWeight: 600)),
                              DataCell(MyText.bodyMedium("\$${data.amount}", fontWeight: 600)),
                            ]))
                        .toList()),
              ),
          ],
        ));
  }
}
