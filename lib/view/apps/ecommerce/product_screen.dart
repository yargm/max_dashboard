import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/ecommerce/product_controller.dart';
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

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with UIMixin {
  ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'ecommerce_product_controller',
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
                      "Ecommerce",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Product List'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard.bordered(
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
                          Expanded(child: MyText.bodyMedium("Product List", fontWeight: 600)),
                          MyButton(
                            onPressed: controller.createProduct,
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.plus, size: 20, color: contentTheme.onPrimary),
                                MySpacing.width(8),
                                MyText.labelMedium('Create Product', color: contentTheme.onPrimary),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            columnSpacing: 102,
                            onSelectAll: (_) => {},
                            headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                            dataRowMaxHeight: 60,
                            showBottomBorder: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                            columns: [
                              DataColumn(label: MyText.labelLarge('id', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('name', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('price', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('rating', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('sku', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('stock', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('orders', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('created_at', color: contentTheme.primary)),
                              DataColumn(label: MyText.labelLarge('action', color: contentTheme.primary)),
                            ],
                            rows: controller.product
                                .mapIndexed((index, data) => DataRow(cells: [
                                      DataCell(MyText.bodyMedium('#${data.id}')),
                                      DataCell(Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          MyContainer.rounded(
                                              paddingAll: 0,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              child: Image.asset(Images.product[index % Images.product.length], height: 40, width: 40, fit: BoxFit.cover)),
                                          MySpacing.width(16),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              MyText.bodyMedium(data.name),
                                              MyText.labelMedium(data.category, muted: true),
                                            ],
                                          )
                                        ],
                                      )),
                                      DataCell(MyText.labelMedium('\$${data.price}')),
                                      DataCell(Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(LucideIcons.star, color: AppColors.ratingStarColor, size: 16),
                                          MySpacing.width(4),
                                          MyText.labelMedium('${data.rating} (${data.ratingCount})')
                                        ],
                                      )),
                                      DataCell(MyText.labelMedium('${data.sku}')),
                                      DataCell(MyText.labelMedium('${data.stock}')),
                                      DataCell(MyText.labelMedium('${data.ordersCount}')),
                                      DataCell(Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          MyText.labelMedium('${Utils.getDateStringFromDateTime(data.createdAt, showMonthShort: true)}'),
                                          MySpacing.width(4),
                                          MyText.labelMedium('${Utils.getTimeStringFromDateTime(data.createdAt, showSecond: false)}',
                                              muted: true, fontWeight: 600)
                                        ],
                                      )),
                                      DataCell(MyContainer.bordered(
                                        onTap: () => {},
                                        padding: MySpacing.xy(6, 6),
                                        borderColor: contentTheme.primary.withAlpha(40),
                                        child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary),
                                      )),
                                    ]))
                                .toList()),
                      ),
                    ],
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
