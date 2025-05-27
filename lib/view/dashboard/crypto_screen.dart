import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxdash/controller/dashboard/crypto_controller.dart';
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
import 'package:maxdash/model/chart_model.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> with UIMixin {
  CryptoController controller = Get.put(CryptoController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
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
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats('assets/coin/ethereum.png', 'ETH', 'Ethereum', '3.754120', '4.2')),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats('assets/coin/bitcoin.png', 'BTC', 'Bitcoin', '12.125620', '-1.3')),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats('assets/coin/chainlink.png', 'LINK', 'Chainlink', '15.874562', '0.8')),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: stats('assets/coin/dogecoin.png', 'DOGE', 'Dogecoin', '8.674930', '5.0')),
                      MyFlexItem(sizes: 'lg-6 md-6', child: marketOverview()),
                      MyFlexItem(sizes: 'lg-6 md-6', child: cryptoStatistics()),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: accountStats("Total Balance", "\$12000.50", LucideIcons.credit_card, contentTheme.success)),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: accountStats("Total Investment", "\$8000.75", LucideIcons.trending_up, contentTheme.info)),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: accountStats("Total Change", "\$500.25", LucideIcons.refresh_cw, contentTheme.warning)),
                      MyFlexItem(sizes: 'lg-3 md-6 sm-6', child: accountStats("Day Change", "\$20.30", LucideIcons.circle_arrow_up, contentTheme.danger)),
                      MyFlexItem(sizes: 'lg-4', child: recentActivity()),
                      MyFlexItem(sizes: 'lg-4', child: topPerformers()),
                      MyFlexItem(sizes: 'lg-4', child: transactionHistory()),
                      MyFlexItem(child: activeOverallGrowth()),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget stats(String coinImage, String coinShortName, String coinName, String count, String change) {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyContainer.rounded(
                height: 44,
                width: 44,
                paddingAll: 0,
                child: Image.asset(coinImage, fit: BoxFit.cover),
              ),
              MySpacing.width(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodySmall(coinShortName, xMuted: true),
                  MyText.bodySmall(coinName),
                ],
              )
            ],
          ),
          MyText.titleLarge('$count $coinShortName'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(change.startsWith("-") ? LucideIcons.trending_down : LucideIcons.trending_up,
                  size: 16, color: change.startsWith("-") ? theme.colorScheme.error : theme.colorScheme.primary),
              MySpacing.width(8),
              MyText.bodySmall("${change.startsWith("-") ? '' : '+'}${change}%",
                  color: change.startsWith("-") ? theme.colorScheme.error : theme.colorScheme.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget marketOverview() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.bodyMedium("Market Overview", fontWeight: 600),
              PopupMenuButton(
                onSelected: controller.onSelectIntervalType,
                itemBuilder: (BuildContext context) {
                  return DateTimeIntervalType.values.map((behavior) {
                    return PopupMenuItem(
                      value: behavior,
                      height: 32,
                      child: MyText.bodySmall(
                        behavior.toString().split('.').last.capitalize.toString(),
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
                      MyText.labelSmall(controller.intervalType.toString().split('.').last.capitalize.toString(), color: theme.colorScheme.onSurface),
                      Icon(LucideIcons.chevron_down, size: 16, color: theme.colorScheme.onSurface)
                    ],
                  ),
                ),
              ),
            ],
          ),
          MySpacing.height(24),
          SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  dateFormat: DateFormat.MMM(),
                  intervalType: controller.intervalType,
                  minimum: DateTime(2016),
                  maximum: DateTime(2016, 10),
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: const NumericAxis(minimum: 80, maximum: 120, labelFormat: r'${value}', axisLine: AxisLine(width: 0)),
              series: _getCandleSeries(),
              trackballBehavior: controller.trackballBehavior,
              tooltipBehavior: TooltipBehavior(),
              zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true, enablePinching: true, enablePanning: true, enableDoubleTapZooming: true)),
        ],
      ),
    );
  }

  List<CandleSeries<ChartSampleData, DateTime>> _getCandleSeries() {
    return <CandleSeries<ChartSampleData, DateTime>>[
      CandleSeries<ChartSampleData, DateTime>(
        enableSolidCandles: controller.enableSolidCandle,
        dataSource: <ChartSampleData>[
          ChartSampleData(x: DateTime(2016, 01, 11), open: 98.97, high: 101.19, low: 95.36, close: 97.13),
          ChartSampleData(x: DateTime(2016, 01, 18), open: 98.41, high: 101.46, low: 93.42, close: 101.42),
          ChartSampleData(x: DateTime(2016, 01, 25), open: 101.52, high: 101.53, low: 92.39, close: 97.34),
          ChartSampleData(x: DateTime(2016, 02), open: 96.47, high: 97.33, low: 93.69, close: 94.02),
          ChartSampleData(x: DateTime(2016, 02, 08), open: 93.13, high: 96.35, low: 92.59, close: 93.99),
          ChartSampleData(x: DateTime(2016, 02, 15), open: 95.02, high: 98.89, low: 94.61, close: 96.04),
          ChartSampleData(x: DateTime(2016, 02, 22), open: 96.31, high: 98.0237, low: 93.32, close: 96.91),
          ChartSampleData(x: DateTime(2016, 02, 29), open: 96.86, high: 103.75, low: 96.65, close: 103.01),
          ChartSampleData(x: DateTime(2016, 03, 07), open: 102.39, high: 102.83, low: 100.15, close: 102.26),
          ChartSampleData(x: DateTime(2016, 03, 14), open: 106.5, high: 106.5, low: 106.5, close: 106.5),
          ChartSampleData(x: DateTime(2016, 03, 21), open: 105.93, high: 107.65, low: 104.89, close: 105.67),
          ChartSampleData(x: DateTime(2016, 03, 28), open: 106, high: 110.42, low: 104.88, close: 109.99),
          ChartSampleData(x: DateTime(2016, 04, 04), open: 110.42, high: 112.19, low: 108.121, close: 108.66),
          ChartSampleData(x: DateTime(2016, 04, 11), open: 108.97, high: 112.39, low: 108.66, close: 109.85),
          ChartSampleData(x: DateTime(2016, 04, 18), open: 108.89, high: 108.95, low: 104.62, close: 105.68),
          ChartSampleData(x: DateTime(2016, 04, 25), open: 105, high: 105.65, low: 92.51, close: 93.74),
          ChartSampleData(x: DateTime(2016, 05, 02), open: 93.965, high: 95.9, low: 91.85, close: 92.72),
          ChartSampleData(x: DateTime(2016, 05, 09), open: 93, high: 93.77, low: 89.47, close: 90.52),
          ChartSampleData(x: DateTime(2016, 05, 16), open: 92.39, high: 95.43, low: 91.65, close: 95.22),
          ChartSampleData(x: DateTime(2016, 05, 23), open: 95.87, high: 100.73, low: 95.67, close: 100.35),
          ChartSampleData(x: DateTime(2016, 05, 30), open: 99.6, high: 100.4, low: 96.63, close: 97.92),
          ChartSampleData(x: DateTime(2016, 06, 06), open: 97.99, high: 101.89, low: 97.55, close: 98.83),
          ChartSampleData(x: DateTime(2016, 06, 13), open: 98.69, high: 99.12, low: 95.3, close: 95.33),
          ChartSampleData(x: DateTime(2016, 06, 20), open: 96, high: 96.89, low: 92.65, close: 93.4),
          ChartSampleData(x: DateTime(2016, 06, 27), open: 93, high: 96.465, low: 91.5, close: 95.89),
          ChartSampleData(x: DateTime(2016, 07, 04), open: 95.39, high: 96.89, low: 94.37, close: 96.68),
          ChartSampleData(x: DateTime(2016, 07, 11), open: 96.75, high: 99.3, low: 96.73, close: 98.78),
          ChartSampleData(x: DateTime(2016, 07, 18), open: 98.7, high: 101, low: 98.31, close: 98.66),
          ChartSampleData(x: DateTime(2016, 07, 25), open: 98.25, high: 104.55, low: 96.42, close: 104.21),
          ChartSampleData(x: DateTime(2016, 08), open: 104.41, high: 107.65, low: 104, close: 107.48),
          ChartSampleData(x: DateTime(2016, 08, 08), open: 107.52, high: 108.94, low: 107.16, close: 108.18),
          ChartSampleData(x: DateTime(2016, 08, 15), open: 108.14, high: 110.23, low: 108.08, close: 109.36),
          ChartSampleData(x: DateTime(2016, 08, 22), open: 108.86, high: 109.32, low: 106.31, close: 106.94),
          ChartSampleData(x: DateTime(2016, 08, 29), open: 109.74, high: 109.74, low: 109.74, close: 109.74),
          ChartSampleData(x: DateTime(2016, 09, 05), open: 107.9, high: 108.76, low: 103.13, close: 103.13),
          ChartSampleData(x: DateTime(2016, 09, 12), open: 102.65, high: 116.13, low: 102.53, close: 114.92),
          ChartSampleData(x: DateTime(2016, 09, 19), open: 115.19, high: 116.18, low: 111.55, close: 112.71),
          ChartSampleData(x: DateTime(2016, 09, 26), open: 111.64, high: 114.64, low: 111.55, close: 113.05),
        ],
        showIndicationForSameValues: true,
        xValueMapper: (ChartSampleData sales, _) => sales.x as DateTime,
        lowValueMapper: (ChartSampleData sales, _) => sales.low,
        highValueMapper: (ChartSampleData sales, _) => sales.high,
        openValueMapper: (ChartSampleData sales, _) => sales.open,
        closeValueMapper: (ChartSampleData sales, _) => sales.close,
        spacing: 0.2,
        width: 0.8,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      )
    ];
  }

  Widget cryptoStatistics() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Crypto Statistics", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(
            height: 329,
            child: SfCartesianChart(
              margin: MySpacing.zero,
              plotAreaBorderWidth: 0,
              legend: Legend(isVisible: false, position: LegendPosition.bottom),
              primaryXAxis: const CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
              primaryYAxis: const NumericAxis(
                  axisLine: AxisLine(width: 0), edgeLabelPlacement: EdgeLabelPlacement.shift, labelFormat: '{value}', majorTickLines: MajorTickLines(size: 0)),
              series: [
                SplineSeries<ChartSampleData, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                    yValueMapper: (ChartSampleData sales, _) => sales.y,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: contentTheme.success,
                    name: 'High'),
                SplineSeries<ChartSampleData, String>(
                  dataSource: controller.chartData,
                  name: 'Low',
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

  Widget accountStats(String title, String data, IconData icon, Color color) {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyContainer(
                color: color,
                child: Icon(icon, color: contentTheme.light),
              ),
              MySpacing.width(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(title, fontWeight: 600, maxLines: 1, overflow: TextOverflow.ellipsis),
                    MySpacing.height(4),
                    MyText.titleLarge(data, fontWeight: 600, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget recentActivity() {
    Widget recentActivityWidget(String coinName, String transactionType, String price, String transactionUpDown, IconData icon) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.roundBordered(
            height: 44,
            width: 44,
            paddingAll: 0,
            child: Icon(icon, size: 20),
          ),
          MySpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(coinName, fontWeight: 600),
                MySpacing.height(4),
                MyText.bodySmall(transactionType, fontWeight: 600, muted: true),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText.bodyMedium(price, fontWeight: 600),
              MySpacing.height(4),
              MyText.bodySmall("${transactionUpDown.startsWith('-') ? '' : '+'}${transactionUpDown}",
                  fontWeight: 600, muted: true, color: transactionUpDown.startsWith('-') ? contentTheme.danger : contentTheme.success),
            ],
          ),
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Recent Activity", fontWeight: 600),
          MySpacing.height(24),
          recentActivityWidget("Bought Ethereum", "MasterCard ***8", "+0.215 BTC", "4320.22 USD", LucideIcons.circle_plus),
          MySpacing.height(24),
          recentActivityWidget("Sold Bitcoin", "PayPal Account", "-0.012 BTC", "-231.56 USD", LucideIcons.circle_minus),
          MySpacing.height(24),
          recentActivityWidget("Transferred Litecoin", "Visa Debit Card ***5", "-2.23 LTC", "-150.99 USD", LucideIcons.arrow_right),
          MySpacing.height(24),
          recentActivityWidget("Bought Cardano", "Bitcoin Wallet", "+500 ADA", "2,650.32 USD", LucideIcons.circle_plus),
          MySpacing.height(24),
          recentActivityWidget("Sold Dogecoin", "Bank Transfer", "-10,000 DOGE", "-756.11 USD", LucideIcons.circle_minus),
        ],
      ),
    );
  }

  Widget topPerformers() {
    Widget topPerformersWidget(String coinName, String shortName, String price, String image) {
      return Row(
        children: [
          MyContainer(
            height: 44,
            width: 44,
            paddingAll: 0,
            child: Image.asset(image),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(coinName, fontWeight: 600),
                MySpacing.height(4),
                MyText.bodySmall(shortName, fontWeight: 600, muted: true),
              ],
            ),
          ),
          MyText.bodyMedium(price, fontWeight: 600),
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Top Performance", fontWeight: 600),
          MySpacing.height(24),
          topPerformersWidget("Bitcoin", "BTC", "\$45,000", "assets/coin/bitcoin.png"),
          MySpacing.height(24),
          topPerformersWidget("Chainlink", "LINK", "\$25.50", "assets/coin/chainlink.png"),
          MySpacing.height(24),
          topPerformersWidget("Dogecoin", "DOGE", "\$0.25", "assets/coin/dogecoin.png"),
          MySpacing.height(24),
          topPerformersWidget("Ethereum", "ETH", "\$3,200", "assets/coin/ethereum.png"),
          MySpacing.height(24),
          topPerformersWidget("Polkadot", "DOT", "\$12.75", "assets/coin/polkadot.png"),
        ],
      ),
    );
  }

  Widget transactionHistory() {
    Widget transactionHistoryWidget(String coinName, String date, String buyPrice, IconData icon) {
      return Row(
        children: [
          MyContainer(
            height: 44,
            width: 44,
            paddingAll: 0,
            color: contentTheme.primary.withValues(alpha: 0.2),
            child: Icon(icon, color: contentTheme.primary),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(coinName, fontWeight: 600),
                MySpacing.height(4),
                MyText.bodySmall(date, fontWeight: 600, muted: true),
              ],
            ),
          ),
          MyText.bodyMedium(buyPrice, fontWeight: 600),
        ],
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Transaction History", fontWeight: 600),
          MySpacing.height(24),
          transactionHistoryWidget("Sent BTC", "12 November 2024 2:15 PM", "0.045 BTC", LucideIcons.arrow_up),
          MySpacing.height(24),
          transactionHistoryWidget("Received ETH", "11 November 2024 9:30 AM", "2.5 ETH", LucideIcons.arrow_down),
          MySpacing.height(24),
          transactionHistoryWidget("Sent LTC", "10 November 2024 5:20 PM", "1.2 LTC", LucideIcons.arrow_up),
          MySpacing.height(24),
          transactionHistoryWidget("Received ADA", "9 November 2024 11:50 PM", "500 ADA", LucideIcons.arrow_down),
          MySpacing.height(24),
          transactionHistoryWidget("Sent DOGE", "8 November 2024 1:10 PM", "10,000 DOGE", LucideIcons.arrow_up),
        ],
      ),
    );
  }

  Widget activeOverallGrowth() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Active Overall Growth", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 170,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge('Type', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Assets', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('IP Address', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge('Amount', color: contentTheme.primary)),
                ],
                rows: controller.coinGrowth
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.labelMedium('Exchange')),
                          DataCell(MyText.labelMedium('${data.asset}')),
                          DataCell(MyText.labelMedium('${Utils.getDateTimeStringFromDateTime(data.date)}')),
                          DataCell(MyText.labelMedium('${data.ipAddress}')),
                          DataCell(MyContainer(
                              paddingAll: 4,
                              color: data.status == 'Success' ? contentTheme.success : contentTheme.danger,
                              child: MyText.labelMedium('${data.status}', color: data.status == 'Success' ? contentTheme.onSuccess : contentTheme.onDanger))),
                          DataCell(MyText.labelMedium('\$${data.amount}')),
                        ]))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
