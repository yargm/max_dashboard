import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/ecommerce/customer_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/utils/utils.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_list_extension.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/images.dart';
import 'package:maxdash/view/layouts/layout.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> with UIMixin {
  CustomerController controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'review_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Customer",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Customer'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: MyContainer.none(
                      borderRadiusAll: 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyButton(
                            onPressed: controller.goToDashboard,
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.monitor,
                                  size: 18,
                                  color: contentTheme.onPrimary,
                                ),
                                MySpacing.width(8),
                                MyText.labelMedium(
                                  'dashboard',
                                  color: contentTheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: MyContainer.none(
                              borderRadiusAll: 4,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: DataTable(
                                sortAscending: true,
                                columnSpacing: 160,
                                onSelectAll: (_) => {},
                                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                                dataRowMaxHeight: 60,
                                showBottomBorder: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                                columns: [
                                  DataColumn(label: MyText.labelLarge('Id', color: contentTheme.primary)),
                                  DataColumn(label: MyText.labelLarge('Name', color: contentTheme.primary)),
                                  DataColumn(label: MyText.labelLarge('Phone', color: contentTheme.primary)),
                                  DataColumn(label: MyText.labelLarge('Balance', color: contentTheme.primary)),
                                  DataColumn(label: MyText.labelLarge('Orders', color: contentTheme.primary)),
                                  DataColumn(label: MyText.labelLarge('Last order at', color: contentTheme.primary)),
                                  DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary))
                                ],
                                rows: controller.customers
                                    .mapIndexed(
                                      (index, data) => DataRow(
                                        cells: [
                                          DataCell(MyText.bodyMedium("#${data.id}")),
                                          DataCell(
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                MyContainer.none(
                                                  borderRadiusAll: 20,
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  child: Image.asset(Images.avatars[index % Images.avatars.length], height: 40, width: 40, fit: BoxFit.cover),
                                                ),
                                                MySpacing.width(15),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    MyText.bodyMedium(data.firstName),
                                                    MySpacing.height(4),
                                                    MyText.bodySmall(data.lastName),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          DataCell(MyText.bodyMedium(data.phoneNumber)),
                                          DataCell(MyText.bodyMedium('\$${data.balance}')),
                                          DataCell(MyText.bodyMedium('${data.ordersCount}')),
                                          DataCell(Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              MyText.labelLarge('${Utils.getDateStringFromDateTime(data.lastOrder, showMonthShort: true)}'),
                                              MySpacing.width(4),
                                              MyText.bodySmall('${Utils.getTimeStringFromDateTime(data.lastOrder, showSecond: false)}',
                                                  muted: true, fontWeight: 600)
                                            ],
                                          )),
                                          DataCell(
                                            Align(
                                              alignment: Alignment.center,
                                              child: MyContainer.bordered(
                                                onTap: () {},
                                                padding: MySpacing.xy(6, 6),
                                                borderColor: contentTheme.primary.withAlpha(40),
                                                child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
