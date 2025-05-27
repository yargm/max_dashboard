import 'package:maxdash/controller/other/basic_table_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/utils/utils.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_list_extension.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BasicTableScreen extends StatefulWidget {
  const BasicTableScreen({super.key});

  @override
  State<BasicTableScreen> createState() => _BasicTableScreenState();
}

class _BasicTableScreenState extends State<BasicTableScreen> with SingleTickerProviderStateMixin, UIMixin {
  late BasicTableController controller;

  @override
  void initState() {
    controller = BasicTableController();
    super.initState();
  }

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
                    MyText.titleMedium("Other", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [MyBreadcrumbItem(name: 'Other'), MyBreadcrumbItem(name: 'Basic Table', active: true)],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  children: [
                    PaginatedDataTable(
                      header: Row(
                        children: [MyText.titleMedium("Product List", fontWeight: 600, fontSize: 20)],
                      ),
                      arrowHeadColor: contentTheme.primary,
                      source: controller.data!,
                      columns: [
                        DataColumn(
                            label: MyText.bodyMedium(
                          'Id',
                          fontWeight: 600,
                        )),
                        DataColumn(
                            label: MyText.bodyMedium(
                          'Name',
                          fontWeight: 600,
                        )),
                        DataColumn(label: MyText.bodyMedium('Code')),
                        DataColumn(label: MyText.bodyMedium('Price')),
                        DataColumn(label: MyText.bodyMedium('QTY')),
                        DataColumn(label: MyText.bodyMedium('Action')),
                      ],
                      columnSpacing: 230,
                      horizontalMargin: 28,
                      rowsPerPage: 10,
                    ),
                    MySpacing.height(12),
                    buildVisitorByChannel()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildVisitorByChannel() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Visitors By Channel", fontWeight: 600),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 110,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(8), style: BorderStyle.solid, width: .4, color: Colors.grey),
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
                          DataCell(Row(
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
                          )),
                        ]))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<Data> data = [];

  MyData(this.data);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(MyText.bodyMedium(
          data[index].id.toString(),
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          data[index].name,
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(data[index].code.toString())),
        DataCell(MyText.bodyMedium(data[index].amount.toString())),
        DataCell(MyText.bodyMedium(data[index].qty.toString())),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.pencil,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
                MySpacing.width(12),
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.trash_2,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
