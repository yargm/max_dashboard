import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxdash/controller/dashboard/ecommerce_controller.dart';
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

class EcommerceScreen extends StatefulWidget {
  const EcommerceScreen({super.key});

  @override
  State<EcommerceScreen> createState() => _EcommerceScreenState();
}

class _EcommerceScreenState extends State<EcommerceScreen> with UIMixin {
  EcommerceController controller = Get.put(EcommerceController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'ecommerce_dashboard_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Ecommerce", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard'),
                        MyBreadcrumbItem(name: 'Ecommerce', active: true),
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
                    MyFlexItem(sizes: 'lg-6 ', child: stats()),
                    MyFlexItem(sizes: "lg-6", child: responseTimeByLocation()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: topCustomer()),
                    MyFlexItem(sizes: "lg-4 md-6", child: costBreakDown()),
                    MyFlexItem(sizes: 'lg-5', child: salesAnalytics()),
                    MyFlexItem(child: productOrder()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget stats() {
    Widget statsWidget(IconData icon, String title, String count, String change, Color color) {
      return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 24,
        height: 140,
        child: Row(
          children: [
            MyContainer(
              paddingAll: 24,
              color: color.withValues(alpha:0.2),
              child: MyContainer(paddingAll: 8, color: color, child: Icon(icon, size: 16, color: contentTheme.light)),
            ),
            MySpacing.width(24),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.labelSmall(title, maxLines: 1),
                    MyText.bodyMedium(count, fontWeight: 600, maxLines: 1),
                    Row(
                      children: [
                        MyContainer(
                          padding: MySpacing.xy(6, 4),
                          color: change[0] == '+' ? Colors.green.withValues(alpha:.2) : theme.colorScheme.error.withValues(alpha:.2),
                          child: MyText.labelSmall(change, color: change[0] == '+' ? Colors.green : theme.colorScheme.error),
                        ),
                        MySpacing.width(8),
                        Expanded(child: MyText.labelSmall("This Month", overflow: TextOverflow.ellipsis))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return MyFlex(contentPadding: false, children: [
      MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget(LucideIcons.shopping_bag, "Total Sales", "12,254", "+4.2%", contentTheme.primary)),
      MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget(LucideIcons.receipt_text, "Total Expenses", "\$28,346.00", "-4.2%", contentTheme.secondary)),
      MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget(LucideIcons.user, "Total Visitors", "1,29,368", "-3.54%", contentTheme.success)),
      MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget(LucideIcons.shopping_basket, "Total Orders", "35,367", "+5.18%", contentTheme.info)),
      MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget(LucideIcons.chart_column, "Average Order Value", "\$120", "+4.48%", contentTheme.dark)),
      MyFlexItem(sizes: 'lg-6 md-6 sm-6', child: statsWidget(LucideIcons.users, "Total Customer", "36,835", "-1.15%", contentTheme.warning)),
    ]);
  }

  Widget salesAnalytics() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Sales Analytics", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(height: 384, child: salesAnalyticsChart()),
        ],
      ),
    );
  }

  SfCartesianChart salesAnalyticsChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: MySpacing.zero,
      primaryXAxis: const CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: const NumericAxis(
          minimum: 30,
          maximum: 80,
          axisLine: AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0)),
      series: [
        SplineSeries<ChartSampleData, String>(
          dataSource: controller.salesAnalyticsData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: true),
          name: 'Pending',
        ),
        SplineSeries<ChartSampleData, String>(
          dataSource: controller.salesAnalyticsData,
          name: 'Complete',
          markerSettings: const MarkerSettings(isVisible: true),
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        )
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  Widget topCustomer() {
    Widget topCustomerData(String name, String cardNumber, int orders, String image) {
      return Row(
        children: [
          MyContainer(
            height: 44,
            width: 44,
            paddingAll: 0,
            borderRadiusAll: 4,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image),
          ),
          MySpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(name, fontWeight: 600, maxLines: 1),
                MyText.labelSmall(cardNumber, maxLines: 1),
              ],
            ),
          ),
          MyText.labelSmall("Orders : $orders"),
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
            MyText.bodyMedium("Top Customer", fontWeight: 600),
            MySpacing.height(24),
            topCustomerData("John Doe", "1234 5678 9012 3456", 21, Images.avatars[0]),
            MySpacing.height(24),
            topCustomerData("Jane Smith", "2345 6789 0123 4567", 22, Images.avatars[1]),
            MySpacing.height(24),
            topCustomerData("Michael Johnson", "3456 7890 1234 5678", 23, Images.avatars[2]),
            MySpacing.height(24),
            topCustomerData("Emily Davis", "4567 8901 2345 6789", 24, Images.avatars[3]),
            MySpacing.height(24),
            topCustomerData("Chris Brown", "5678 9012 3456 7890", 25, Images.avatars[4]),
            MySpacing.height(24),
            topCustomerData("Olivia Wilson", "6789 0123 4567 8901", 26, Images.avatars[5]),
          ],
        ));
  }

  Widget costBreakDown() {
    Widget buildCircleChartData(Color color, String name, String price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyContainer.rounded(
                paddingAll: 4,
                color: color,
              ),
              MySpacing.width(8),
              MyText.labelMedium(name)
            ],
          ),
          MyText.labelSmall(price),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Cost BreakDown", overflow: TextOverflow.ellipsis, fontWeight: 600),
              InkWell(onTap: () {}, child: Icon(LucideIcons.move_right, size: 16)),
            ],
          ),
          SizedBox(
            height: 293,
            child: SfCircularChart(
              margin: MySpacing.zero,
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                DoughnutSeries<ChartSampleData, String>(
                    radius: '80%',
                    explode: true,
                    explodeOffset: '10%',
                    dataSource: controller.circleChart,
                    pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.y,
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [MyText.titleMedium("Top Channel"), MyText.titleMedium("Value")],
          ),
          MySpacing.height(12),
          buildCircleChartData(const Color.fromRGBO(9, 0, 136, 1), "Salary", "\$54,847"),
          MySpacing.height(8),
          buildCircleChartData(const Color.fromRGBO(147, 0, 119, 1), "Bill", "\$58,188"),
          MySpacing.height(8),
          buildCircleChartData(const Color.fromRGBO(228, 0, 124, 1), "Marketing", "\$24,618"),
          MySpacing.height(8),
          buildCircleChartData(const Color.fromRGBO(255, 189, 57, 1), "Other", "\$15,651")
        ],
      ),
    );
  }

  Widget responseTimeByLocation() {
    Widget buildResponseTimeByLocationData(String currentTime, String price, IconData icon, Color iconColor) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.circle_dot_dashed, size: 16),
              MySpacing.width(8),
              MyText.bodyMedium(currentTime),
            ],
          ),
          MySpacing.height(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.bodyLarge(price, fontSize: 20, fontWeight: 600, muted: true),
              MySpacing.width(8),
              Icon(icon, size: 16, color: iconColor),
            ],
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
        children: [
          Padding(
            padding: MySpacing.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyText.titleMedium(
                    "Response time by location",
                    overflow: TextOverflow.ellipsis,
                    fontWeight: 600,
                  ),
                ),
                PopupMenuButton(
                  onSelected: controller.onSelectedTimeByLocation,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyText.labelSmall(controller.selectedTimeByLocation.toString(), color: theme.colorScheme.onSurface),
                        Icon(LucideIcons.chevron_down, size: 16, color: theme.colorScheme.onSurface)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          MySpacing.height(12),
          MyFlex(
            wrapCrossAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            wrapAlignment: WrapAlignment.center,
            children: [
              MyFlexItem(
                sizes: "lg-4 md-4 sm-6",
                child: buildResponseTimeByLocationData("Current Week", "\$1886.52", LucideIcons.corner_right_up, contentTheme.success),
              ),
              MyFlexItem(
                sizes: "lg-4 md-4 sm-6",
                child: buildResponseTimeByLocationData("Conversation", "5.68%", LucideIcons.corner_right_up, contentTheme.success),
              ),
              MyFlexItem(
                sizes: "lg-4 md-4 sm-6",
                child: buildResponseTimeByLocationData("Customers", "59K", LucideIcons.corner_right_up, contentTheme.red),
              ),
            ],
          ),
          MySpacing.height(12),
          const Divider(),
          Padding(
            padding: MySpacing.all(16),
            child: SizedBox(
              height: 267,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: controller.chart,
                axes: <ChartAxis>[
                  NumericAxis(
                      numberFormat: NumberFormat.compact(),
                      majorGridLines: const MajorGridLines(width: 0),
                      opposedPosition: true,
                      name: 'yAxis1',
                      interval: 1000,
                      minimum: 0,
                      maximum: 7000)
                ],
                series: [
                  ColumnSeries<ChartSampleData, String>(
                      animationDuration: 2000,
                      width: 0.5,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      color: contentTheme.primary,
                      dataSource: controller.chartData,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                      name: 'Unit Sold'),
                  LineSeries<ChartSampleData, String>(
                      animationDuration: 4500,
                      animationDelay: 2000,
                      dataSource: controller.chartData,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.yValue,
                      yAxisName: 'yAxis1',
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Total Transaction')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productOrder() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Product Order", fontWeight: 600),
          MySpacing.height(20),
          if (controller.order.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 98,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 60,
                  showBottomBorder: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                  columns: [
                    DataColumn(label: MyText.labelLarge('Order Id', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Customer Name', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Location', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Order Date', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Payments', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Quantity', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Price', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Total Amount', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  ],
                  rows: controller.order
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(MyText.bodyMedium("#${data.orderId}", fontWeight: 600)),
                            DataCell(MyText.bodyMedium(data.customerName, fontWeight: 600)),
                            DataCell(MyText.bodyMedium(data.location, fontWeight: 600)),
                            DataCell(MyText.bodyMedium("${Utils.getDateStringFromDateTime(data.orderDate)}", fontWeight: 600)),
                            DataCell(MyText.bodyMedium(data.payment, fontWeight: 600)),
                            DataCell(MyText.bodyMedium("${data.quantity}", fontWeight: 600)),
                            DataCell(MyText.bodyMedium("\$${data.price}", fontWeight: 600)),
                            DataCell(MyText.bodyMedium("\$${data.quantity * data.price}", fontWeight: 600)),
                            DataCell(MyContainer(
                              padding: MySpacing.xy(8, 4),
                              color: getStatusColor(data.status)?.withAlpha(32),
                              child: MyText.bodySmall(
                                data.status,
                                fontWeight: 600,
                                color: getStatusColor(data.status),
                              ),
                            )),
                          ]))
                      .toList()),
            ),
        ],
      ),
    );
  }

  Color? getStatusColor(String? status) {
    switch (status) {
      case "Delivered":
        return contentTheme.primary;
      case "Shopping":
        return contentTheme.success;
      case "New":
        return contentTheme.warning;
      case "Pending":
        return contentTheme.danger;
      default:
        return null;
    }
  }
}
