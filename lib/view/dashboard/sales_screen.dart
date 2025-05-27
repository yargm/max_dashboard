import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxdash/controller/dashboard/sales_controller.dart';
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

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> with UIMixin {
  SalesController controller = Get.put(SalesController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'sales_dashboard_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Crypto", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Dashboard'),
                        MyBreadcrumbItem(name: 'Crypto', active: true),
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
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Total Income", "\$3,50,000", "15.00%")),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Profit", "\$1,20,000", "10.00%")),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Total Views", "15000", "5.00%")),
                    MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats("Conversion Rate", "18.75%", "3.50%")),
                    MyFlexItem(sizes: 'lg-6 md-6', child: visitorsReport()),
                    MyFlexItem(sizes: 'lg-6 md-6', child: otherStatistics()),
                    MyFlexItem(sizes: 'lg-3.5 md-6', child: recentTransaction()),
                    MyFlexItem(sizes: 'lg-3.5 md-6', child: recentActivity()),
                    MyFlexItem(sizes: 'lg-2.5 md-6', child: countryWiseSale()),
                    MyFlexItem(sizes: 'lg-2.5 md-6', child: dealSource()),
                    MyFlexItem(child: recentOrder()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget stats(String title, String changes, String percentage) {
    return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 24,
        height: 144,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium(title),
            MyText.titleLarge(changes, fontWeight: 600),
            Row(
              children: [
                MyContainer(
                  paddingAll: 4,
                  color: contentTheme.success.withValues(alpha:0.2),
                  child: MyText.labelSmall(percentage, color: contentTheme.success),
                ),
                MySpacing.width(8),
                Expanded(child: MyText.labelSmall("Compare to last month")),
              ],
            )
          ],
        ));
  }

  Widget visitorsReport() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Visitors Report", fontWeight: 600),
          MySpacing.height(24),
          SfCartesianChart(
            margin: MySpacing.zero,
            primaryXAxis: CategoryAxis(),
            tooltipBehavior: controller.visitorChart,
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
                  color: contentTheme.success,
                  dataSource: controller.visitorChartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.y,
                  name: 'Unit Sold'),
              LineSeries<ChartSampleData, String>(
                  animationDuration: 4500,
                  animationDelay: 2000,
                  dataSource: controller.visitorChartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.yValue,
                  yAxisName: 'yAxis1',
                  markerSettings: const MarkerSettings(isVisible: true),
                  name: 'Total Transaction')
            ],
          ),
        ],
      ),
    );
  }

  Widget otherStatistics() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Other Statistics", fontWeight: 600),
          MySpacing.height(24),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            margin: MySpacing.zero,
            legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, position: LegendPosition.bottom),
            primaryXAxis: const NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, majorGridLines: MajorGridLines(width: 0)),
            primaryYAxis: const NumericAxis(labelFormat: '{value}', axisLine: AxisLine(width: 0), majorTickLines: MajorTickLines(color: Colors.transparent)),
            series: [
              LineSeries<ChartData, num>(
                  dataSource: controller.statisticsData,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y,
                  name: 'Pending',
                  color: contentTheme.secondary,
                  markerSettings: const MarkerSettings(isVisible: true)),
              LineSeries<ChartData, num>(
                  dataSource: controller.statisticsData,
                  name: 'Delivered',
                  color: contentTheme.primary,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y2,
                  markerSettings: const MarkerSettings(isVisible: true))
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          )
        ],
      ),
    );
  }

  Widget recentTransaction() {
    Widget recentTransactionWidget(String transactionMethod, String transactionType, String price, String date, IconData? icon, Color color) {
      return Row(
        children: [
          MyContainer.rounded(
            height: 44,
            width: 44,
            paddingAll: 0,
            color: color.withValues(alpha:0.2),
            child: Icon(icon, color: color),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(transactionMethod, fontWeight: 600, maxLines: 1),
                MySpacing.height(4),
                MyText.bodySmall(transactionType, fontWeight: 600, muted: true, maxLines: 1),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText.bodyMedium(price, fontWeight: 600),
              MyText.bodySmall(date, fontWeight: 600, muted: true),
            ],
          ),
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 475,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: MyText.bodyMedium("Recent Transaction", fontWeight: 600)),
              InkWell(onTap: () {}, child: MyText.labelSmall("View All", fontWeight: 600)),
            ],
          ),
          MySpacing.height(24),
          recentTransactionWidget("Digital Wallet", "Online Transaction", "\$350.00", "Nov 23, 2023", LucideIcons.gift, contentTheme.primary),
          MySpacing.height(24),
          recentTransactionWidget("Bank Account", "Purchase", "\$150.00", "Nov 23, 2023", LucideIcons.coins, contentTheme.success),
          MySpacing.height(24),
          recentTransactionWidget("PayPal", "Transfer", "\$500.00", "Nov 22, 2023", LucideIcons.shopping_cart, contentTheme.purple),
          MySpacing.height(24),
          recentTransactionWidget("Digital Wallet", "Bill Payment", "\$120.00", "Nov 21, 2023", LucideIcons.wallet, contentTheme.warning),
          MySpacing.height(24),
          recentTransactionWidget("Credit Card", "Subscription", "\$20.00", "Nov 20, 2023", LucideIcons.id_card, contentTheme.danger),
          MySpacing.height(24),
          recentTransactionWidget("Digital Wallet", "Refund", "\$100.00", "Nov 19, 2023", LucideIcons.circle_arrow_up, contentTheme.info),
        ],
      ),
    );
  }

  Widget countryWiseSale() {
    Widget countryWiseSaleWidget(String image, name, count) {
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
          Expanded(child: MyText.bodyMedium(name, fontWeight: 600, overflow: TextOverflow.ellipsis)),
          MyContainer(
            borderRadiusAll: 8,
            padding: MySpacing.xy(8, 8),
            color: contentTheme.success.withAlpha(36),
            child: MyText.bodySmall(numberFormatter(count), fontWeight: 600, color: contentTheme.success),
          )
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 475,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Country wise sale", fontWeight: 600),
          MySpacing.height(24),
          countryWiseSaleWidget('assets/country/united_states.png', "France", "25000"),
          MySpacing.height(24),
          countryWiseSaleWidget('assets/country/argentina.png', "Brazil", "17500"),
          MySpacing.height(24),
          countryWiseSaleWidget('assets/country/germany.png', "India", "12500"),
          MySpacing.height(24),
          countryWiseSaleWidget('assets/country/mexico.png', "Japan", "22000"),
          MySpacing.height(24),
          countryWiseSaleWidget('assets/country/russia.png', "United Kingdom", "30000"),
          MySpacing.height(24),
          countryWiseSaleWidget('assets/country/canada.png', "Australia", "18000"),
        ],
      ),
    );
  }

  Widget recentActivity() {
    Widget recentActivityWidget(String title) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.rounded(paddingAll: 4, child: MyContainer.rounded(paddingAll: 4, color: contentTheme.primary, child: MyContainer.rounded(paddingAll: 4))),
          MySpacing.width(12),
          Expanded(child: MyText.bodyMedium(title, fontWeight: 600, maxLines: 2))
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 475,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Recent Activity", fontWeight: 600),
          MySpacing.height(24),
          recentActivityWidget(
              "Ava Thompson placed an order for 3 units of Wireless Earbuds, 2 units of Bluetooth Speakers, and 1 unit of Smart Home Thermostat"),
          MySpacing.height(24),
          recentActivityWidget(
              "Noah Jackson upgraded his subscription to the Gold service plan, gaining access to premium features, priority support, and 20GB cloud storage for his team of 15 employees."),
          MySpacing.height(24),
          recentActivityWidget(
              "Emma Harris added 5 new items to the shopping cart, including a designer handbag, a set of luxury skincare products, a Bluetooth speaker, a fitness tracker, and a pair of leather boots"),
          MySpacing.height(24),
          recentActivityWidget(
              "Liam Davis purchased 1 unit of Electric Scooter, along with an additional helmet and charging station for enhanced convenience. Delivery expected in 5-7 business days."),
          MySpacing.height(24),
          recentActivityWidget(
              "Mason Martinez returned 2 units of Smartphone, citing dissatisfaction with the camera quality. The items will be processed for a full refund once inspected."),
          MySpacing.height(24),
          recentActivityWidget(
              "Isabella Robinson upgraded to the Platinum Plan with 5 users, unlocking advanced analytics tools, exclusive discounts, and premium customer support for her growing e-commerce team."),
          MySpacing.height(24),
          recentActivityWidget(
              "Elijah Walker completed a purchase of 6 ergonomic office chairs, 3 sit-stand desks, and a set of new monitor arms for the team, improving the comfort and productivity of the workspace."),
        ],
      ),
    );
  }

  Widget dealSource() {
    Widget dealSourceWidget(String image, String title, String subtitle, String totalLeads) {
      return Row(
        children: [
          MyContainer.rounded(
            height: 44,
            width: 44,
            paddingAll: 0,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600, maxLines: 1),
                MyText.bodySmall(subtitle, maxLines: 1),
              ],
            ),
          ),
          MyText.bodyMedium('\$$totalLeads', fontWeight: 600),
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 475,
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
          MySpacing.height(24),
          dealSourceWidget("assets/social/twitter-logo.png", "Twitter", "twitter.com", "50"),
        ],
      ),
    );
  }

  Widget recentOrder() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Recent Order", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 150,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge('Product', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Quantity', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Customer', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Price', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                ],
                rows: controller.recentOrder
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.labelMedium(data.productName)),
                          DataCell(MyText.labelMedium('${data.quantity}')),
                          DataCell(Row(
                            children: [
                              MyContainer.rounded(
                                height: 32,
                                width: 32,
                                paddingAll: 0,
                                child: Image.asset(Images.avatars[index % Images.avatars.length]),
                              ),
                              MySpacing.width(12),
                              MyText.labelMedium('${data.customer}'),
                            ],
                          )),
                          DataCell(
                            MyContainer(
                              paddingAll: 4,
                              color: data.status == 'Shipped'
                                  ? contentTheme.success
                                  : data.status == 'Delivery'
                                      ? contentTheme.info
                                      : contentTheme.danger,
                              child: MyText.labelMedium(
                                '${data.status}',
                                color: data.status == 'Success' ? contentTheme.onSuccess : contentTheme.onDanger,
                              ),
                            ),
                          ),
                          DataCell(MyText.labelMedium('\$${data.price}')),
                          DataCell(MyText.labelMedium('${Utils.getDateTimeStringFromDateTime(data.orderDate)}')),
                          DataCell(Row(
                            children: [
                              MyContainer.rounded(
                                onTap: () {},
                                paddingAll: 8,
                                color: contentTheme.primary,
                                child: Icon(LucideIcons.eye, size: 16, color: contentTheme.onPrimary),
                              ),
                              MySpacing.width(20),
                              MyContainer.rounded(
                                onTap: () {},
                                paddingAll: 8,
                                color: contentTheme.secondary,
                                child: Icon(LucideIcons.pencil, size: 16, color: contentTheme.onSecondary),
                              ),
                            ],
                          )),
                        ]))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
